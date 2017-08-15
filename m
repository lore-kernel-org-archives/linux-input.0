From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/3] HID: prodikeys: constify snd_rawmidi_ops
 structures
Date: Tue, 15 Aug 2017 11:03:12 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708151103020.30597@cbobk.fhfr.pm>
References: <1502784594-14670-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39183 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751819AbdHOJDP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Aug 2017 05:03:15 -0400
In-Reply-To: <1502784594-14670-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Aug 2017, Julia Lawall wrote:

> This snd_rawmidi_ops structure is only passed as the third
> argument of snd_rawmidi_set_ops.  This argument is const, so the
> snd_rawmidi_ops structure can be const too.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/hid/hid-prodikeys.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
> index f095bf8..49c4bd3 100644
> --- a/drivers/hid/hid-prodikeys.c
> +++ b/drivers/hid/hid-prodikeys.c
> @@ -593,7 +593,7 @@ static void pcmidi_in_trigger(struct snd_rawmidi_substream *substream, int up)
>  	pm->in_triggered = up;
>  }
>  
> -static struct snd_rawmidi_ops pcmidi_in_ops = {
> +static const struct snd_rawmidi_ops pcmidi_in_ops = {
>  	.open = pcmidi_in_open,
>  	.close = pcmidi_in_close,
>  	.trigger = pcmidi_in_trigger

Applied to for-4.14/upstream, thanks.

-- 
Jiri Kosina
SUSE Labs

