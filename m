From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 04 Jun 2011 13:26:28 +0200
Message-ID: <4DEA1664.4090409@absence.it>
References: <4DE8FC4A.9010401@absence.it> <4DE8FFE0.5070506@absence.it> <20110604084338.GD7194@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110604084338.GD7194@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Il 04/06/2011 10:43, Mattia Dongili ha scritto:
> when sony_call_snc_handle(handle, 0x200,&result) fails above you will
> be reporting -1 via the acpi bus. The old code restored the event and
> reported the raw number instead.

You are right, does the following sony_nc_notify modification look fine 
to you?

/* hotkey event, a key has been pressed, retrieve it */
value = sony_nc_hotkeys_decode(handle);
if (value > 0) /* known event */
	sony_laptop_report_input_event(value);
else /* restore the original event */
	value = event;
