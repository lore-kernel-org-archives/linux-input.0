From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: prodikeys: make needlessly global symbols static
Date: Thu, 21 Jul 2011 13:59:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107211359300.7300@pobox.suse.cz>
References: <1311232893.10976.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311232893.10976.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Don Prince <dhprince.devel@yahoo.co.uk>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 21 Jul 2011, Axel Lin wrote:

> The following symbols are not referenced outside this file so
> there's no need for it to be in the global name space.
> 
>   pcmidi_sustained_note_release
>   init_sustain_timers
>   stop_sustain_timers
>   pcmidi_handle_report
>   pcmidi_setup_extra_keys
>   pcmidi_snd_initialise
>   pcmidi_snd_terminate
> 
> Make them static.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
