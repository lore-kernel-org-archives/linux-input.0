From: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: support i2c write-read transfers in
 hid-cp2112
Date: Wed, 8 Jul 2015 11:34:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081133350.10183@pobox.suse.cz>
References: <1434621340-10422-1-git-send-email-ellen@cumulusnetworks.com> <CAAj6DX03vzNHVLE2gx+zOCud-3WWUnewYCc2-z-wXKhDPHRYQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAj6DX03vzNHVLE2gx+zOCud-3WWUnewYCc2-z-wXKhDPHRYQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 20 Jun 2015, Antonio Borneo wrote:

> > Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
> > ---
> >  drivers/hid/hid-cp2112.c |   74 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 55 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > index 5a72819..00d062a 100644
> > --- a/drivers/hid/hid-cp2112.c
> > +++ b/drivers/hid/hid-cp2112.c
> > @@ -153,6 +153,7 @@ MODULE_DEVICE_TABLE(hid, cp2112_devices);
> >  struct cp2112_device {
> >         struct i2c_adapter adap;
> >         struct hid_device *hdev;
> > +       int hwversion;
> 
> No need for int; u8 is enough (value is copyed from buf[2] that is u8).
> Put the new u8 field few lines below, together with the other u8, to
> avoid extra padding.
> 
> No need to send immediately a new version. Let's see if there is any
> other comment and if someone can test it before me.

Antonio, is there any result of your testing? I have put this patch on 
hold waiting for your word on it, but it has been ~3 weeks already.

Thanks,

-- 
Jiri Kosina
SUSE Labs
