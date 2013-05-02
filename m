From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] HID: hid-steelseries fix led class build issue
Date: Thu, 2 May 2013 14:58:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1305021455260.941@chino.kir.corp.google.com>
References: <51816271.3040400@infradead.org> <1367476041-25760-1-git-send-email-simon@mungewell.org> <5182DFA3.3040707@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5182DFA3.3040707@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2 May 2013, Randy Dunlap wrote:

> > ---
> >  drivers/hid/hid-steelseries.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> > index 2ed995c..dbd5e2e 100644
> > --- a/drivers/hid/hid-steelseries.c
> > +++ b/drivers/hid/hid-steelseries.c
> > @@ -19,7 +19,8 @@
> >  #include "usbhid/usbhid.h"
> >  #include "hid-ids.h"
> >  
> > -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> > +#if defined(CONFIG_LEDS_CLASS) || \
> > +    (defined(CONFIG_LEDS_CLASS_MODULE) && defined(CONFIG_HID_STEELSERIES_MODULE))
> >  #define SRWS1_NUMBER_LEDS 15
> >  struct steelseries_srws1_data {
> >  	__u16 led_state;

While we're working on getting a signed-off-by line, the clean way of 
handling this is

#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
