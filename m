Received: from users.org.uk (users.org.uk [91.203.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1E3C09EA
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.203.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684185; cv=none; b=CJfO3mdT5MPITud2avdGES4DDfZzD0pgBxJTDNkvwKpL3j49XAN5TmOS2IeFKy+qn8exa+YtmUBQg6VBOki+/iOroo152V2R0sSyR6t5ca4jjeICRXieKCazSRg4OlEfCaZFVoqO2ByPwa892lnnvuJfi4RC6jzPLaZjo/V4fNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684185; c=relaxed/simple;
	bh=lZ7gCdySFwMo1qQkiBzjMc4SkSI7L6CzPj9btqR1QW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7bziFUSaAFZehQalRFWynBPf78BwcBV3mjkU9wtmToUSR2xBM957p6vvlLTunsqEr37F0jfl399zJsboW9NtqL8jZs0AE7+PK3QJPDrCTE6EmBzsY7wB2wYszqHUoCYRwQUMAWLY6IBGTeO3iW1uHuVdn+Hvh+uC5ZB6+JuEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com; spf=pass smtp.mailfrom=arachsys.com; arc=none smtp.client-ip=91.203.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arachsys.com
Received: from richard by users.org.uk with local
	(envelope-from <richard@arachsys.com>)
	id 1wqXyx-000000008Mf-2ioY;
	Sun, 02 Aug 2026 15:20:07 +0000
Date: Sun, 2 Aug 2026 15:20:07 +0000
From: Richard Davies <richard@arachsys.com>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mathias Gottschlag <mgottschlag@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] Input: focaltech - fix array out-of-bounds in
 focaltech_process_rel_packet
Message-ID: <am9gJ2siGC34jTVB@users.org.uk>
References: <20260701190932.14960-1-richard@arachsys.com>
 <akVqYaOOKNrkDf_h@users.org.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akVqYaOOKNrkDf_h@users.org.uk>

Hi Dmitry, [and fixing Hans cc:ed email address]

Do you have any feedback on my patch to fix my UBSAN error?
I'm keen to get the fix upstream.

Is there any other maintainer who I should also copy for review?

Thank you,

Richard.


Richard Davies wrote:
>Richard Davies wrote:
>>Make finger2 (and also finger1) unsigned, so that if the finger index in
>>the packet is 0 then subtracting 1 creates an array index which overflows
>>above the existing check for FOC_MAX_FINGERS, as the existing comment says
>>it should, instead of writing to state->fingers[-1].
>
>Some further context for my patch...
>
>I get errors such as the following on my laptop running Ubuntu 26.04 LTS:
>
>[   52.422376] ------------[ cut here ]------------
>[   52.422381] UBSAN: array-index-out-of-bounds in /build/linux-IJm0IA/linux-7.0.0/drivers/input/mouse/focaltech.c:221:17
>[   52.422386] index -1 is out of range for type 'focaltech_finger_state [5]'
>[   52.422389] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G S                  7.0.0-27-generic #27-Ubuntu PREEMPT(lazy) 
>[   52.422392] Tainted: [S]=CPU_OUT_OF_SPEC
>[   52.422393] Hardware name: ASUSTeK COMPUTER INC. N550JK/N550JK, BIOS N550JK.208 09/26/2014
>[   52.422395] Call Trace:
>[   52.422396]  <IRQ>
>[   52.422399]  show_stack+0x49/0x60
>[   52.422405]  dump_stack_lvl+0x5f/0x90
>[   52.422409]  dump_stack+0x10/0x18
>[   52.422410]  ubsan_epilogue+0x9/0x39
>[   52.422416]  __ubsan_handle_out_of_bounds.cold+0x50/0x55
>[   52.422421]  focaltech_process_packet+0x541/0x560 [psmouse]
>[   52.422435]  focaltech_process_byte+0x23/0x30 [psmouse]
>[   52.422443]  psmouse_handle_byte+0x19/0x70 [psmouse]
>[   52.422450]  psmouse_receive_byte+0x8d/0x300 [psmouse]
>[   52.422456]  ps2_interrupt+0xa1/0x110
>[   52.422462]  serio_interrupt+0x4b/0xb0
>[   52.422464]  i8042_handle_data+0x189/0x370
>[   52.422466]  ? timekeeping_adjust+0x1e/0x180
>[   52.422469]  ? __note_gp_changes+0x1f3/0x270
>[   52.422473]  ? sched_balance_domains+0xd9/0x380
>[   52.422475]  i8042_interrupt+0x15/0x60
>[   52.422478]  __handle_irq_event_percpu+0x59/0x230
>[   52.422481]  handle_irq_event+0x36/0x90
>[   52.422484]  handle_edge_irq+0xd3/0x1a0
>[   52.422487]  __common_interrupt+0x50/0x160
>[   52.422489]  ? irq_enter_rcu+0x75/0x90
>[   52.422492]  common_interrupt+0xb0/0xe0
>[   52.422495]  </IRQ>
>[   52.422496]  <TASK>
>[   52.422497]  asm_common_interrupt+0x27/0x40
>[   52.422499] RIP: 0010:cpuidle_enter_state+0xca/0x700
>[   52.422502] Code: 00 e8 ca 91 dd fe e8 15 ee ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 06 7f db fe 80 7d d0 00 0f 85 c6 01 00 00 fb 0f 1f 44 00 00 <45> 85 e4 0f 88 3e 02 00 00 4d 63 fc 49 83 ff 0a 0f 83 1d 05 00 00
>[   52.422503] RSP: 0018:ffffd20bc00f3e00 EFLAGS: 00000246
>[   52.422505] RAX: 0000000000000000 RBX: ffff8ef0a6dbd6c0 RCX: 0000000000000000
>[   52.422507] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>[   52.422507] RBP: ffffd20bc00f3e50 R08: 0000000000000000 R09: 0000000000000000
>[   52.422508] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000005
>[   52.422509] R13: 0000000c349ddabc R14: ffffffffb1d54c40 R15: 0000000000000005
>[   52.422511]  ? tick_nohz_stop_tick+0x5e/0x260
>[   52.422516]  cpuidle_enter+0x30/0x50
>[   52.422520]  call_cpuidle+0x21/0x50
>[   52.422523]  cpuidle_idle_call+0x16b/0x1f0
>[   52.422526]  do_idle+0x94/0xf0
>[   52.422528]  cpu_startup_entry+0x29/0x30
>[   52.422529]  start_secondary+0x125/0x180
>[   52.422532]  ? soft_restart_cpu+0x14/0x14
>[   52.422534]  common_startup_64+0x13e/0x141
>[   52.422537]  </TASK>
>[   52.422537] ---[ end trace ]---
>
>These no longer occur when this patch is applied.
>
>I found similar reports from other users at
>https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2125250
>
>I found a related review comment when this code was first written at
>https://lore.kernel.org/linux-input/20141111171554.GB27720@dtor-ws/
>
>>Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
>>Signed-off-by: Richard Davies <richard@arachsys.com>
>>---
>>drivers/input/mouse/focaltech.c | 2 +-
>>1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
>>index 43f9939b7c63..d3ad4af5aa09 100644
>>--- a/drivers/input/mouse/focaltech.c
>>+++ b/drivers/input/mouse/focaltech.c
>>@@ -197,7 +197,7 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
>>{
>>	struct focaltech_data *priv = psmouse->private;
>>	struct focaltech_hw_state *state = &priv->state;
>>-	int finger1, finger2;
>>+	unsigned int finger1, finger2;
>>
>>	state->pressed = packet[0] >> 7;
>>	finger1 = ((packet[0] >> 4) & 0x7) - 1;
>>-- 
>>2.53.0
