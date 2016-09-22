From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH -next] HID: alps: fix error return code in
 alps_input_configured()
Date: Thu, 22 Sep 2016 11:10:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609221110330.22028@cbobk.fhfr.pm>
References: <1474470725-4789-1-git-send-email-weiyj.lk@gmail.com> <20160922073532.GA9916@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753305AbcIVJLB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 05:11:01 -0400
In-Reply-To: <20160922073532.GA9916@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Thu, 22 Sep 2016, Benjamin Tissoires wrote:

> > Fix to return a negative error code from the error handling
> > case instead of 0, as done elsewhere in this function.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/hid/hid-alps.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> > index 2808da9..507372e 100644
> > --- a/drivers/hid/hid-alps.c
> > +++ b/drivers/hid/hid-alps.c
> > @@ -384,7 +384,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
> >  
> >  		input2 = input_allocate_device();
> >  		if (!input2) {
> > -			input_free_device(input2);
> 
> Tiny nitpick: this change is not entirely related to the patch and
> commit message. But it's OK-ish carrying this over through this patch.
> (it's basically a no-op given that input2 is null).
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Fair enough; I've ammended the changelog to reflect the removal of 
superfluous input_free_device() call and applied, thanks.

-- 
Jiri Kosina
SUSE Labs

