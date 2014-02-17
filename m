From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 7/9] HID: remove hid_get_raw_report in struct
 hid_device
Date: Mon, 17 Feb 2014 14:20:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171420160.1192@pobox.suse.cz>
References: <1391636004-29354-1-git-send-email-benjamin.tissoires@redhat.com> <1391636004-29354-8-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1402171414490.1192@pobox.suse.cz>
 <CAN+gG=E__6ejV_BqdtM8iwyM-UCdB1G49nvEZn3WTeELixqs4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=E__6ejV_BqdtM8iwyM-UCdB1G49nvEZn3WTeELixqs4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Frank Praznik <frank.praznik@oh.rr.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 17 Feb 2014, Benjamin Tissoires wrote:

> >> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> >> index f5a2b19..12439e1 100644
> >> --- a/drivers/hid/uhid.c
> >> +++ b/drivers/hid/uhid.c
> >> @@ -404,7 +404,6 @@ static int uhid_dev_create(struct uhid_device *uhid,
> >>       hid->uniq[63] = 0;
> >>
> >>       hid->ll_driver = &uhid_hid_driver;
> >> -     hid->hid_get_raw_report = uhid_hid_get_raw;
> >
> > I'll queue a followup patch on top of this that completely removes
> > uhid_hid_get_raw(), as it's unused now.
> 
> Jiri, please don't. It was a mistake which was fixed in the next patch
> series (2/14: HID: uHID: implement .raw_request). It was already
> reviewed by David, so you can apply it right now.

Yeah, I just came to the same conclusion during review as we speak. I will 
sort it out.

Thanks.

-- 
Jiri Kosina
SUSE Labs
