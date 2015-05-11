From: Alan Wu <alan.c.wu@gmail.com>
Subject: Fwd: [PATCH] hid:Change vendor id for USB_DEVICE_ID_MS_TYPE_COVER_3
 to correct id in hid-ids.h
Date: Mon, 11 May 2015 12:06:36 -0700
Message-ID: <CABkLPOLYdufCsLiT8fdskk5Dqw8oTQ+SiCdXLeXE2CvxWOHS2Q@mail.gmail.com>
References: <1431139528-19821-1-git-send-email-xerofoify@gmail.com>
	<alpine.LNX.2.00.1505111043180.8186@pobox.suse.cz>
	<5550D74F.2040504@gmail.com>
	<CABkLPOKd07+EgcVX8QOumZ9uaCVsgesMy=ArzpgHdfLyF=wE4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABkLPOKd07+EgcVX8QOumZ9uaCVsgesMy=ArzpgHdfLyF=wE4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello,
  The Surface Pro 3 Type Cover that I have from US is 045e:07dc.  At
the time, there was no Surface 3 to distinguish from.  I believe many
others also have this code.

Alan


On Mon, May 11, 2015 at 9:22 AM, nick <xerofoify@gmail.com> wrote:
>
>
>
> On 2015-05-11 04:44 AM, Jiri Kosina wrote:
> > On Fri, 8 May 2015, Nicholas Krause wrote:
> >
> >> This fixes the bug,https://bugzilla.kernel.org/show_bug.cgi?id=97951
> >> related to incorrecting using 0x07dc for the vendor id for
> >> USB_DEVICE_ID_MS_TYPE_COVER_3 devices and instead changing in
> >> to the correct vendor id of 0x07de.
> >
> > Adding Alan Wu, who originally submitted the USB_DEVICE_ID_MS_TYPE_COVER_3
> > quirk.
> >
> >> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> >> ---
> >>  drivers/hid/hid-ids.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >> index 41f167e..2e51947 100644
> >> --- a/drivers/hid/hid-ids.h
> >> +++ b/drivers/hid/hid-ids.h
> >> @@ -670,7 +670,7 @@
> >>  #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
> >>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
> >>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> >> -#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
> >> +#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
> >>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
> >
> > Why do you think we just don't need both of them (i.e. there are
> > persumably two devices that need this patch).
> >
> Jiri,
> This is because I assumed as he didn't state the JP hardware and therefore only
> one was affected. However I will send in a v2 changing both hardware product's
> vendor id.
> Cheers,
> Nick
