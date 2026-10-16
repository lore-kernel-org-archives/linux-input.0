Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC23839B9;
	Fri, 16 Oct 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142876; cv=none; b=CIxxaC2K1+hi8nbNXAqHv/4M/KRWuwdY3L7PnTeYZboYSPy8F7Ea6WzNzMr0F9AC1d17KNOctu2mEDCiW+2eAVs9WKgutRSzP9P1OLHvxlz7OGHBdQCUaWY6wFbn/KOUhBqE83C/Dno4A9L3zNm7qLWcn003TwGpSe300l22qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142876; c=relaxed/simple;
	bh=K657Mg7Cwj7liQtBBiQS3BGoKBiSoLRfNNTdIVOV5Ek=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d/w17ibSf8tFuO6XKongPCyvDTPXLzvT546OaJYBL4Np9pyNMNCLhzWZ4ZQUnUXAE1kXzRh/YfH80SBDyKaHLbjbwuFgkawG6ZutnncEVfbxoenAAdr5x9jKsGsWLW1AeCgmE7KkL9pDE188R7tq+I0g3GJh/5dhXoGHtVmzdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktz0oiFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktz0oiFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598421F000C5;
	Fri, 16 Oct 2026 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142874;
	bh=Dtz34czj8HRDYLhjmWmFJ6s5HnzFVHn18HMUnVqZi54=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Ktz0oiFz3KhKRAlSZQE49DeOaUPliBjWwqebnqd6JtdLcJcpJjLRlafzw43KPT4W6
	 kH5WhbauOzHrbu7lw5Qbz39yIpjAcWBZWKtzKHnYB4ylZ6yHGRbNqFNIq00D9bMZ4W
	 CrYtqLOEbo9n7GIqmlBa59nCeMwmvVwfx7eQr3WNybgWXjlvCjupXptydhZyYAsjVJ
	 19G1puCAoKxq22p+UzBH8F8jjV0Oqe7qMrXaCpQP1e1Q1SQ/48ngQx43De/fwaqLrH
	 PYAJU6qaxRWw7KQTaa7axnloKNH63y3Jj1bvUIkt/RXSigDWsp0bjzDkxh565wckiB
	 grXLE9l5slXeA==
Date: Fri, 16 Oct 2026 11:27:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] HID: wacom: check input devices in the report
 handlers
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Message-ID: <pp502o8o-09p1-2041-7420-63849p9s8741@xreary.bet>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet> <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Ping, Jason, can you please Ack/Review this series? Thanks.

On Sun, 27 Sep 2026, Jinmo Yang wrote:

> This is the extended version Jiri asked for in
> <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>, after Dmitry's
> observation that "there are many more places in the driver where it used
> wacom->pad_input without verifying that it exists".
> 
> The audit turned out broader than pad_input. Of the 155 lines in
> wacom_wac.c that reference pen_input, touch_input or pad_input, three
> places already test the pointer first:
> 
>   wacom_wac.c:1807/1815  wacom_tpc_irq                 pen, touch
>   wacom_wac.c:1210       wacom_intuos_bt_process_data  pad
>   wacom_wac.c:2192       wacom_wac_pad_event           (HID_GENERIC)
> 
> so the inconsistency is inside the legacy dispatch rather than between it
> and the HID_GENERIC path. The clearest illustration is two adjacent lines
> in wacom_intuos_bt_process_data(), one checked and one not:
> 
> 	input_sync(wacom->pen_input);		/* :1209 */
> 	if (wacom->pad_input)			/* :1210 */
> 		input_sync(wacom->pad_input);
> 
> Why the pointers can be NULL on a *successful* probe
> ====================================================
> For a non-HID_GENERIC device the report handler is selected by
> features.type, which comes from the id table (wacom_sys.c:2945), while the
> three input devices are allocated from what the report descriptor declares.
> When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> wacom_setup_inputs() frees that input device, sets the pointer to NULL and
> still returns 0 (wacom_sys.c:2172-2196) - the "no pen in use on this
> interface" case. wacom_wac_irq() then still routes reports to a handler
> that dereferences it.
> 
> No error injection is needed. A descriptor declaring only touch usages
> leaves pen_input and pad_input NULL; one declaring only pen usages leaves
> touch_input and pad_input NULL.
> 
> What the series fixes
> =====================
> 15 locations, each reproduced as a KASAN NULL-pointer dereference from one
> /dev/uhid device plus a single UHID_INPUT2 write, with no privilege beyond
> access to /dev/uhid:
> 
>   patch  file:line          function                       pointer
>   1      wacom_wac.c:4229   wacom_report_numbered_buttons  pad
>   2      wacom_wac.c:137    wacom_penpartner_irq           pen
>   2      wacom_wac.c:227    wacom_pl_irq                   pen
>   2      wacom_wac.c:244    wacom_ptu_irq                  pen
>   2      wacom_wac.c:303    wacom_dtus_irq                 pad
>   2      wacom_wac.c:326    wacom_dtus_irq                 pen
>   2      wacom_wac.c:391    wacom_graphire_irq             pen
>   2      wacom_wac.c:444    wacom_graphire_irq             pad
>   3      wacom_wac.c:594    wacom_intuos_pad               pad
>   4      wacom_wac.c:1209   wacom_intuos_bt_process_data   pen
>   4      wacom_wac.c:1232   wacom_intuos_bt_irq            pen
>          (both covered by one check at wacom_intuos_bt_irq() entry)
>   5      wacom_wac.c:3100   wacom_bpt_touch                touch
>   5      wacom_wac.c:3117   wacom_bpt_touch                pad
>   5      wacom_wac.c:3130   wacom_bpt3_touch_msg           touch
>   5      wacom_wac.c:3178   wacom_bpt3_button_msg          pad
> 
> Patch 1 also guards wacom_wac_finger_count_touches(), and patch 2 also
> guards wacom_dtu_irq(); both are reachable with a NULL pointer but their
> only dereference is in a dev_dbg(), so they do not fault with
> CONFIG_DYNAMIC_DEBUG=n.
> 
> Dereferences that are reached only through dev_dbg() are otherwise out of
> scope here. A few remain, on unknown-report paths in wacom_dtus_irq(),
> wacom_graphire_irq() and wacom_intuos_irq(); guarding those needs a
> separate look at what a pen-only or pad-only interface should still
> report, so I have left them for a follow-up rather than mixing them in.
> 
> Approach
> ========
> A check where each pointer is taken, which is what wacom_tpc_irq() already
> does. Where a handler serves both pen and pad reports - wacom_dtus_irq(),
> wacom_graphire_irq(), wacom_bpt_touch() - the checks are per branch rather
> than at function entry, so an interface that has a pad but no pen keeps
> delivering pad events.
> 
> A per-features.type table of required input devices would be one place
> instead of 15, but a handler's needs vary by report id, so such a mask
> would have to demand every input the handler might touch and would then
> reject reports that work today on a partial interface. I am happy to build
> that instead if you would rather have it.
> 
> Testing
> =======
> linux-next 20260925 (7.3.0-rc4-next-20260925-gf5f84daefcd9), x86_64,
> CONFIG_KASAN_GENERIC=y, CONFIG_DYNAMIC_DEBUG=n. 27 uhid reproducer cases
> covering the sites above plus the dev_dbg-only ones, one fresh VM per case
> because the oops leaves driver_input_lock held:
> 
>                               before    after
>     KASAN faults                  17        0
>     probe failures                 0        0
>     hidraw nodes created          26       26
>     input devices registered      25       25
> 
> and the set of input devices registered is identical in all 27 cases, so
> the checks remove the faults without changing what a device exposes. The
> one case that creates no device is a product whose table entry sets
> .check_for_hid_type, which uhid cannot satisfy; it behaves the same before
> and after.
> 
> Each patch builds standalone with no new warnings, and checkpatch --strict
> reports 0 errors, 0 warnings and 0 checks for all five.
> 
> Not in this series
> ==================
> Jason, your review of "HID: wacom: add report length validation in irq
> handlers" (17 May) asked for the length checks to move into the
> sub-functions with len passed in, plus WACOM_PKGLEN_* names. Eight
> handlers already take len and eight do not, and six of those eight are
> also on the list above, so that work overlaps this series closely. I have
> kept it out here because I have only reproduced and verified the
> input-device faults; I would rather send the length revision once it has
> the same evidence behind it, on top of this series.
> 
> Jinmo Yang (5):
>   HID: wacom: check the input device in the shared report helpers
>   HID: wacom: check the input devices in the legacy irq handlers
>   HID: wacom: check the input device in wacom_intuos_pad()
>   HID: wacom: check the input device in wacom_intuos_bt_irq()
>   HID: wacom: check the input devices in the Bamboo handlers
> 
>  drivers/hid/wacom_wac.c | 97 +++++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 27 deletions(-)
> 
> 
> base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
> -- 
> 2.53.0
> 

-- 
Jiri Kosina
SUSE Labs

