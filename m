From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: hidp: Stop I/O on shutdown
Date: Thu, 6 Oct 2011 22:15:02 -0300
Message-ID: <20111007011502.GB13474@joana>
References: <1314360362-24580-1-git-send-email-dh.herrmann@googlemail.com>
 <20111007011138.GA13474@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37971 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab1JGBOZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 21:14:25 -0400
Content-Disposition: inline
In-Reply-To: <20111007011138.GA13474@joana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org

* Gustavo Padovan <padovan@profusion.mobi> [2011-10-06 22:11:38 -0300]:

> Hi David,
> 
> Sorry for the big delay to respond to this.
> 
> * David Herrmann <dh.herrmann@googlemail.com> [2011-08-26 14:06:02 +0200]:
> 
> > Current hidp driver purges the in/out queue on HID shutdown, but does
> > not prevent further I/O. If a driver uses hidp_output_raw_report or
> > hidp_get_raw_report during shutdown, the driver hangs for 5 or 10
> > seconds per call until it gets a timeout.
> > That is, if the output queue of an HID driver has 10 messages pending,
> > it will take 50s until hid_destroy_device() will return. The
> > hidp_session_sem semaphore is held during shutdown so no other HID
> > device may be added/removed during this time.
> > 
> > This patch makes hidp_output_raw_report and hidp_get_raw_report fail if
> > session->terminate is true. Also hidp_session will wakeup all current
> > calls to these functions to cancel the current operations.
> > 
> > We already purge the current I/O queues on hidp_stop(), so this data loss
> > does not change the behaviour of the HID drivers.
> > 
> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > ---
> >  net/bluetooth/hidp/core.c |   40 ++++++++++++++++++++++++++--------------
> >  1 files changed, 26 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index 4423e3a..e134528 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
> > @@ -255,6 +255,9 @@ static int __hidp_send_ctrl_message(struct hidp_session *session,
> >  
> >  	BT_DBG("session %p data %p size %d", session, data, size);
> >  
> > +	if (atomic_read(&session->terminate))
> > +		return -EIO;
> > +
> >  	skb = alloc_skb(size + 1, GFP_ATOMIC);
> >  	if (!skb) {
> >  		BT_ERR("Can't allocate memory for new frame");
> > @@ -320,6 +323,13 @@ static int hidp_send_report(struct hidp_session *session, struct hid_report *rep
> >  	return hidp_queue_report(session, buf, rsize);
> >  }
> >  
> > +static void hidp_wakeup_reportq(struct hidp_session *session)
> > +{
> > +	clear_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
> > +	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
> > +	wake_up_interruptible(&session->report_queue);
> > +}
> > +
> >  static int hidp_get_raw_report(struct hid_device *hid,
> >  		unsigned char report_number,
> >  		unsigned char *data, size_t count,
> > @@ -329,6 +339,7 @@ static int hidp_get_raw_report(struct hid_device *hid,
> >  	struct sk_buff *skb;
> >  	size_t len;
> >  	int numbered_reports = hid->report_enum[report_type].numbered;
> > +	int ret;
> >  
> >  	switch (report_type) {
> >  	case HID_FEATURE_REPORT:
> > @@ -352,8 +363,9 @@ static int hidp_get_raw_report(struct hid_device *hid,
> >  	session->waiting_report_number = numbered_reports ? report_number : -1;
> >  	set_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
> >  	data[0] = report_number;
> > -	if (hidp_send_ctrl_message(hid->driver_data, report_type, data, 1))
> > -		goto err_eio;
> > +	ret = hidp_send_ctrl_message(hid->driver_data, report_type, data, 1);
> > +	if (ret)
> > +		goto err;
> >  
> >  	/* Wait for the return of the report. The returned report
> >  	   gets put in session->report_return.  */
> > @@ -365,11 +377,13 @@ static int hidp_get_raw_report(struct hid_device *hid,
> >  			5*HZ);
> >  		if (res == 0) {
> >  			/* timeout */
> > -			goto err_eio;
> > +			ret = -EIO;
> > +			goto err;
> >  		}
> >  		if (res < 0) {
> >  			/* signal */
> > -			goto err_restartsys;
> > +			ret = -ERESTARTSYS;
> > +			goto err;
> >  		}
> >  	}
> >  
> > @@ -390,14 +404,10 @@ static int hidp_get_raw_report(struct hid_device *hid,
> >  
> >  	return len;
> >  
> > -err_restartsys:
> > -	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
> > -	mutex_unlock(&session->report_mutex);
> > -	return -ERESTARTSYS;
> > -err_eio:
> > +err:
> >  	clear_bit(HIDP_WAITING_FOR_RETURN, &session->flags);
> >  	mutex_unlock(&session->report_mutex);
> > -	return -EIO;
> > +	return ret;
> >  }
> >  
> >  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
> > @@ -422,11 +432,10 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
> >  
> >  	/* Set up our wait, and send the report request to the device. */
> >  	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
> > -	if (hidp_send_ctrl_message(hid->driver_data, report_type,
> > -			data, count)) {
> > -		ret = -ENOMEM;
> > +	ret = hidp_send_ctrl_message(hid->driver_data, report_type, data,
> > +									count);
> > +	if (ret)
> >  		goto err;
> > -	}
> >  
> >  	/* Wait for the ACK from the device. */
> >  	while (test_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags)) {
> > @@ -733,6 +742,9 @@ static int hidp_session(void *arg)
> >  	remove_wait_queue(sk_sleep(intr_sk), &intr_wait);
> >  	remove_wait_queue(sk_sleep(ctrl_sk), &ctrl_wait);
> >  
> > +	atomic_inc(&session->terminate);
> 
> At this point seeems that terminate is already > 1.
> 
> > +	hidp_wakeup_reportq(session);
> 
> just inline hidp_wakeup_reportq here, no need to create a function for this.

Nevermind, I fixed it for you. Patch is now applied. Thanks.

	Gustavo
