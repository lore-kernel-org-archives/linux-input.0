From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: USB: driver for CM109 chipset
Date: Thu, 30 Aug 2007 01:07:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708300107110.2460@twin.jikos.cz>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
 <46D1CB97.5030000@db.org>  <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
  <Pine.LNX.4.64.0708271143310.2460@twin.jikos.cz>
 <7f45d9390708282238w7174d105i351e81cd19037d14@mail.gmail.com>
 <Pine.LNX.4.64.0708291029350.2460@twin.jikos.cz>  <46D54385.4010704@db.org>
 <7f45d9390708291237k168d8e16w2fb60f0dc010d482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <7f45d9390708291237k168d8e16w2fb60f0dc010d482@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Shaun Jackman <sjackman@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 29 Aug 2007, Shaun Jackman wrote:

> > @@ -405,6 +408,7 @@ static const struct hid_blacklist {
> >         { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
> >         { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT, HID_QUIRK_IGNORE },
> >         { USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K, HID_QUIRK_IGNORE },
> > +       { USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109, HID_QUIRK_IGNORE },
> >
> >         { USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_FLAIR, HID_QUIRK_IGNORE },
> >         { USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_302, HID_QUIRK_IGNORE },
> A minor detail, but the CMEDIA entry should be sorted alphabetically,
> as the comment says. See below.

I have already fixed up the Alfred's patch when merging it into my tree, 
but thanks anyway!

-- 
Jiri Kosina
