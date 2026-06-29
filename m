Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070434389E
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741426; cv=pass; b=VCwkG+r68qRhbtvWwU+4UVZxzURw/z0uDtlCOcAAiF0HBNBJL5I4leO/ZN7LVv9qo3c0yMhh9SsRIkn1sof2Xtan0BLXxe/zsxV731vNd/+PivFOHuhFNtUd7e2RtEjnEoqtXxBn65lga8UkYHdEZsGTKnNWD1iBSzFXiXX2VZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741426; c=relaxed/simple;
	bh=2GlTqcqZolvpRlCy8zteERsmk+Utw/Jlon2njm1Y+4I=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJj6UAQmKZB0FCQLcRmOHZZbqNFBL34x81bqWohtRttW0ZjRy0sPJtkm5+nyZ8b7qYA4vRSJ/bQMSXnO3+HoEvsAdFg5YqpHN3PkGX1nu+f+qJNkpkFGJ1Y+P5IGq0snIvxBUGeUzUyUNPqVsq1TWFRNYdKMNd9AH7omI9uwW1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvRFxFT7; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvRFxFT7"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8000e21f014so36652657b3.2
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 06:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741424; cv=none;
        d=google.com; s=arc-20260327;
        b=eDK/zzlkWAyv3G9lNS7uNP5HGcu5KJ82YaZbGATkIeI0jOrM2gfq1UNwXxz9sjrOKw
         ff1uoEGVOoTBITjGTr3IdG3jQVdcj2vgQ7tRRdQuojtwKYD7z5gTl1Kg9Hu4UQosaThi
         U/sK5IbzVroh9A35uHn3Ai4A99QYP+DW5q9+flw/cT8RRGd/WCvroINbM0dpdPGyobDv
         qnjxERwu4GM8BXK1KppBzKr5iL6bUennNO8Gm67Xf1CUqXBdE5/UGPFxrZKWxWg/Nan3
         tM6RWowziQ+0LXtyPxFVdhCCaJrcu8m9DFw6DtpjC6LAGc2Y6Pnz8aSgDxh+eqpjTFlu
         /a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=2GlTqcqZolvpRlCy8zteERsmk+Utw/Jlon2njm1Y+4I=;
        fh=/LV0b5VYJuqYLXRUlcdRyl23K8+UL6aGmkkJJe3d/pE=;
        b=ebOT03cpAs7mChUd6MjsyGiWlXeFTvPqCAZJ1AqTpZe9osQGx/HLqdt4EwixcB67U/
         Dvxiby24veD9s5DGNJokyUfJBmh0bWiCYEaQfPuT6RPs/q9c6oFDhUlt28+U++bL+mOS
         15B7QG0X1eJ1Frye+vn7XNCEFB0yWO3CDqhTMza+3g4tT8e2FLJX+w8iZss9ZQcQZUpo
         Zn23GD+YJpeLvDrvoZ+RoLohQlEL+m53HlVYrwHsEZrJZY4YvuH25z9HDcr5Ps1wULfx
         2bO18UlNW9+hv4Ko/8iN7psSapHaDD4pDsNyKlU0tiz/y6AcQQABWXtq9JnxWY/1P4Ed
         NTnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741424; x=1783346224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2GlTqcqZolvpRlCy8zteERsmk+Utw/Jlon2njm1Y+4I=;
        b=cvRFxFT7Bv2QAz4wYX2s0lnrFqURNQcVACjQHtAzFfv/rc+GaAP2FD+4Ep04cf8OND
         mXI7EEdXacTylhHc9CDMp9dugBy+2MC6yPxKzqdo9ZegjGP73PTmxMAtoCj4AVtdE2uR
         Fwdk7UrWW9jNFtEXvTnnyHa1kefQ+uVeYMBHA5t61/ri9eU+5m+aX0EdnMByhFK0l002
         KwgBIZXZHcY4k3HLsCKpGuWszRbZG8GW4Zgi/tmtYWdBLzGQINISR21zk7D0KshzfD17
         43V874kCH8iCMD3ULwknhuIn/NE1ikjobiqtckg0sXlouHXmYqHhYKGVdet/QCjOqHsl
         eTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741424; x=1783346224;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GlTqcqZolvpRlCy8zteERsmk+Utw/Jlon2njm1Y+4I=;
        b=TI/vBAqHTIP0KXuI5MQnQXLr+immQcLUSg0Nw+Rgtc0viFbGox6ODUyfs3nqNORs3s
         zUmA+CEgWMRIm5Hmv52R/FIM8oacvDXEKTDpWiN3x5ZRNMhO7KlgVUrzHzDrWubsOEYZ
         NViSl+JqSoAmPfhNkn3HwwtfRMdbuqjURzV5yEhCMT0/HN4Chk4y/RB+U6t7e9nz2XHb
         s5DwcfpQsKutIb0yfNFgo8buTl+GvOwjta04auGmGIlfc7fvltwX2NIe8O/OvrVEl5A0
         w7scfFuvkFkV1/cNlwujRuaNzeaf8yv8nwfI9p4dhRCIznHBPCGj4RDWBGp7H1nFJW/W
         uuxg==
X-Forwarded-Encrypted: i=1; AHgh+RpMENBin0yWJTBF2RHtNNzmbyuaKmGcAL5tHuqfcpkZOH10Ssw3PhfQYOJBG/mbR7S/Ady8vTNJ31PNgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZsJX6JYisyW1cLM99757/CQ88/u0rw06kmTbyqshW+HbzkyQ
	U05bG2oE3Ktz8lBKbNyhXwe18diaM8fomoEYQ68TaolP+5FCrjtPlau/G8RCryHUcFP0N+Zy7rj
	6UvRndKsCX5SWbck6ou78/qg3Ag1sbCo=
X-Gm-Gg: AfdE7ckATkIrexxHgQQ50Vd5gsGOEXqdFdIvdZnKhZ0mG130P9SBfM7EHW6TSKCRYwE
	R8iqB9ThQ+/KyHt56McVN41hLJhYaOhg8eQENFIZrI1zcq/BLjyiOL1euyG56G+83nZibJACkN0
	HieSAijmUyS8bmrDvRt+RI7zHQx9LP7MtaGYDZqL7hiHQSY90aYKpFX0dCmZH/KKfOuE8pTF91N
	5/eB1xy5d7e6cBDAVcS9nNRXP8sCZFDRJ5uYds7XJmv3P84eNz/Vnl7/cBuQOyyykoMDdeq
X-Received: by 2002:a05:690c:4c05:b0:80e:54a:83df with SMTP id
 00721157ae682-80e054a84ddmr56540307b3.47.1782741423995; Mon, 29 Jun 2026
 06:57:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:02 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:02 -0500
In-Reply-To: <20260628222617.226-1-hdanton@sina.com>
References: <20260628222617.226-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:57:02 -0500
X-Gm-Features: AVVi8CeK-iMyzVoSrjfA7YEbuXwUTSgPpMoNgTYMXw0eu23uU_JM8F8Ypf7s_mc
Message-ID: <CAMuQ4bUuSP=J6Fv=TuzPL6Y34NC3v-rC-O8kGqh86gbUcF8H+g@mail.gmail.com>
Subject: Re: [PATCH] HID: hiddev: keep state alive through disconnect unlock
To: Hillf Danton <hdanton@sina.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

The missing interleaving is that mutex_unlock() clears the owner
before taking wait_lock. A contender already spinning on existancelock
can acquire it after that owner clear, reach the final-release path,
and free hiddev before the disconnecting task reaches
raw_spin_lock_irqsave(&lock->wait_lock, ...). It does not need to be
woken by the disconnecting task.

That is also why mutex_unlock() explicitly requires the containing
object to remain alive until the call returns. I will make this
interleaving explicit in v2.

Thanks,
Yousef

On Mon, 29 Jun 2026 06:26:15 +0800, Hillf Danton <hdanton@sina.com> wrote:
> On Sun, 28 Jun 2026 11:32:45 +0200 Yousef Alhouseen wrote:
> > hiddev_disconnect() drops existancelock before freeing the hiddev state,
> > but a waiting final file release can run as soon as the mutex becomes
> > available. On PREEMPT_RT, that waiter may free hiddev while the disconnect
> > thread is still executing the mutex slow-unlock path, causing a
> > use-after-free in the mutex implementation.
> >
> The root cause is not specified as clearly as expected.
>
> hiddev_disconnect() hiddev_release()
> --- ---
> mutex_lock(&hiddev->existancelock);
> hiddev->exist = 0;
>
> if (hiddev->open) {
> hid_hw_close(hiddev->hid);
> wake_up_interruptible(&hiddev->wait);
> mutex_unlock(&hiddev->existancelock);
> __mutex_unlock_slowpath()
> raw_spin_lock_irqsave() //UAF
>
> mutex_lock(&list->hiddev->existancelock);
> if (!--list->hiddev->open) {
> if (list->hiddev->exist) {
> hid_hw_close(list->hiddev->hid);
> hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
> } else {
> mutex_unlock(&list->hiddev->existancelock);
> kfree(list->hiddev); // free mem
> vfree(list);
> return 0;
> }
> }
> mutex_unlock(&list->hiddev->existancelock);
>
> Given the syzbot report, uaf occured upon acquiring the raw spinlock in
> __mutex_unlock_slowpath(), but no mutex waiter could be waken up without
> the raw spinlock held, thus the report sounds false positive.
>
> > Give the connection and each open file an explicit reference. Drop each
> > reference only after its existancelock critical section has completed, so
> > the state cannot be freed from the other unlock path.
> >
> > Fixes: 079034073faf ("HID: hiddev cleanup -- handle all error conditions properly")
> > Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/hid/usbhid/hiddev.c | 37 +++++++++++++++++++------------------
> > include/linux/hiddev.h | 2 ++
> > 2 files changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> > index 6378801b22c6..21396481995b 100644
> > --- a/drivers/hid/usbhid/hiddev.c
> > +++ b/drivers/hid/usbhid/hiddev.c
> > @@ -46,6 +46,12 @@ struct hiddev_list {
> > struct mutex thread_lock;
> > };
> >
> > +static void hiddev_put(struct hiddev *hiddev)
> > +{
> > + if (refcount_dec_and_test(&hiddev->refcount))
> > + kfree(hiddev);
> > +}
> > +
> > /*
> > * Find a report, given the report's type and ID. The ID can be specified
> > * indirectly by REPORT_ID_FIRST (which returns the first report of the given
> > @@ -216,26 +222,21 @@ static int hiddev_fasync(int fd, struct file *file, int on)
> > static int hiddev_release(struct inode * inode, struct file * file)
> > {
> > struct hiddev_list *list = file->private_data;
> > + struct hiddev *hiddev = list->hiddev;
> > unsigned long flags;
> >
> > - spin_lock_irqsave(&list->hiddev->list_lock, flags);
> > + spin_lock_irqsave(&hiddev->list_lock, flags);
> > list_del(&list->node);
> > - spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
> > + spin_unlock_irqrestore(&hiddev->list_lock, flags);
> >
> > - mutex_lock(&list->hiddev->existancelock);
> > - if (!--list->hiddev->open) {
> > - if (list->hiddev->exist) {
> > - hid_hw_close(list->hiddev->hid);
> > - hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
> > - } else {
> > - mutex_unlock(&list->hiddev->existancelock);
> > - kfree(list->hiddev);
> > - vfree(list);
> > - return 0;
> > - }
> > + mutex_lock(&hiddev->existancelock);
> > + if (!--hiddev->open && hiddev->exist) {
> > + hid_hw_close(hiddev->hid);
> > + hid_hw_power(hiddev->hid, PM_HINT_NORMAL);
> > }
> >
> > - mutex_unlock(&list->hiddev->existancelock);
> > + mutex_unlock(&hiddev->existancelock);
> > + hiddev_put(hiddev);
> > vfree(list);
> >
> > return 0;
> > @@ -270,6 +271,7 @@ static int __hiddev_open(struct hiddev *hiddev, struct file *file)
> > spin_unlock_irq(&hiddev->list_lock);
> >
> > file->private_data = list;
> > + refcount_inc(&hiddev->refcount);
> >
> > return 0;
> >
> > @@ -897,6 +899,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> > INIT_LIST_HEAD(&hiddev->list);
> > spin_lock_init(&hiddev->list_lock);
> > mutex_init(&hiddev->existancelock);
> > + refcount_set(&hiddev->refcount, 1);
> > hid->hiddev = hiddev;
> > hiddev->hid = hid;
> > hiddev->exist = 1;
> > @@ -937,9 +940,7 @@ void hiddev_disconnect(struct hid_device *hid)
> > if (hiddev->open) {
> > hid_hw_close(hiddev->hid);
> > wake_up_interruptible(&hiddev->wait);
> > - mutex_unlock(&hiddev->existancelock);
> > - } else {
> > - mutex_unlock(&hiddev->existancelock);
> > - kfree(hiddev);
> > }
> > + mutex_unlock(&hiddev->existancelock);
> > + hiddev_put(hiddev);
> > }
> > diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
> > index 2164c03d2c72..8e9f8a33e359 100644
> > --- a/include/linux/hiddev.h
> > +++ b/include/linux/hiddev.h
> > @@ -13,6 +13,7 @@
> > #ifndef _HIDDEV_H
> > #define _HIDDEV_H
> >
> > +#include <linux/refcount.h>
> > #include <uapi/linux/hiddev.h>
> >
> >
> > @@ -24,6 +25,7 @@ struct hiddev {
> > int minor;
> > int exist;
> > int open;
> > + refcount_t refcount;
> > struct mutex existancelock;
> > wait_queue_head_t wait;
> > struct hid_device *hid;
> > --
> > 2.54.0
