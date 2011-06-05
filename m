From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Mon, 6 Jun 2011 07:38:16 +0900
Message-ID: <20110605223815.GC26835@kamineko.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
 <4DEA1664.4090409@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DEA1664.4090409@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jun 04, 2011 at 01:26:28PM +0200, Marco Chiappero wrote:
> Il 04/06/2011 10:43, Mattia Dongili ha scritto:
> >when sony_call_snc_handle(handle, 0x200,&result) fails above you will
> >be reporting -1 via the acpi bus. The old code restored the event and
> >reported the raw number instead.
> 
> You are right, does the following sony_nc_notify modification look
> fine to you?
> 
> /* hotkey event, a key has been pressed, retrieve it */
> value = sony_nc_hotkeys_decode(handle);
> if (value > 0) /* known event */
> 	sony_laptop_report_input_event(value);
> else /* restore the original event */
> 	value = event;

it's a bit out of context but I guess it should work. It would be good
to have sony_nc_hotkeys_decode also report the "not decoded" case
consistently back to callers though.
-- 
mattia
:wq!
