Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811B3E5A0C
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916897; cv=none; b=NWBD3SiD5fWgzNvL4Pd0NW2DhV9W+8sNuLz/sKem1LyVY6qYR8tl+OEQBhdgkf1ZCRdeUHcLFAdxMYNmuAEuDnDoUbuHSMRknjuWwHdEy7gON7f5c6UwRsrY5MatcogBB7nLk4qgVu86EDu55BAMqp12tvTPH7bE0fehEM5noG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916897; c=relaxed/simple;
	bh=5nbgeTlwPmpvxBjsWXUMA4e+lDFnLr7P4RDG2gdlXMs=;
	h=Subject:Date:Cc:Mime-Version:References:In-Reply-To:To:Message-Id:
	 Content-Disposition:From:Content-Type; b=hPsVzDwr0dyL+NMDESvG2Dnxh3f0cZnAcJQqEV/PD0HmnwNm2W2IfpElcbWnWyeoRUK9w//dqpJ+wfSf9rvYqqKkw5qNymT4VNXf0HFTXE0mtfWndAvHGpNvtAnkCODu2zxtct3pJW4NQtOBSmzf1RGMzUR4GeZM3le74EE0x9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Qk9mnCWd; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Qk9mnCWd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785916888; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5nbgeTlwPmpvxBjsWXUMA4e+lDFnLr7P4RDG2gdlXMs=;
 b=Qk9mnCWdzGgvSrGCBwpgCx0fjBzp338Slz7vZSnIaKNRc5gRMMcmKjmCLG0on5pd8dGc40
 Gce/RTNqjOtRtOGesBFrsdp++N3KDxx+pHsbRMWRe0uEVfjjPaUm79b1zCPx7tMGKR/+rQ
 UahBr75Xz0N+i5Bn2DaWdqpK6k6DY9mwnXq6ykVu7uozmUt0lG8LWbkvBOyZMOMce/7w3R
 9V0e7CL8lJ7jW2bvm3g7WNlmy3odbDlqNOw1ujXcF4WJ0pKuFrfUku/f6oAebbzdoBH2a8
 7RchS99MU/JN2GcBnH4fqmqqVJclKBoSHPGj/Najo0S+BNtxp9UgxTovStJS2w==
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Date: Wed, 5 Aug 2026 16:01:12 +0800
Content-Transfer-Encoding: 7bit
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>, <linux-input@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc> <anJGWjlmRxNMoVLG@pve> <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com> <anK_oQqFpZLwCA-a@google.com>
In-Reply-To: <anK_oQqFpZLwCA-a@google.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, 
	"Derek John Clark" <derekjohn.clark@gmail.com>
Message-Id: <anLtyBB-Vq2D6REw@pve>
Content-Disposition: inline
Received: from pve ([111.40.58.243]) by smtp.feishu.cn with ESMTPS; Wed, 05 Aug 2026 16:01:16 +0800
X-Lms-Return-Path: <lba+26a72edce+f8d438+vger.kernel.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8

Hi Derek, Dmitry,

Derek wrote:
> Out of curiosity, do you have a device available to test as well? If
> so, which model do you have?

I don't have any OneXPlayer hardware. I found this bug by creating a
gen2 OXP device through /dev/uhid and tearing it down under KASAN in
QEMU, not on a real device, and I'm not deeply familiar with the HID
subsystem overall.

On disable_delayed_work_sync() I seem to be caught between your two
positions. Derek:

> I don't think the bug fix switching to disable_delayed_work_sync is
> worth the side effects without first addressing the global drvdata
> issue. That would introduce a true regression to fix a theoretical
> logic bug. I would rather you either switch to the devm_alloc drvdata
> first or hold that change until I'm able to do it later myself.

Dmitry:

> If there is possibility to have multiple instances then this driver is
> FUBAR in the current shape: one device instance fires up work items
> for another device. So holding the patch makes no sense IMO.

I'm not well placed to own the per-device drvdata refactor: I have no
hardware to validate the multi-interface behavior, and I don't have the
HID-subsystem familiarity to do that rework confidently. So I'd rather
not take that piece on.

Given that, what would you like me to do? The realistic contribution I
can stand behind is a minimal v3 that only fixes the use-after-free I
actually found and verified -- cancel_delayed_work() ->
cancel_delayed_work_sync() in oxp_hid_remove() (the v1 approach),
reverting v2's probe change and dropping disable_delayed_work_sync().
It's KASAN-verified, introduces no regression, and needs no hardware.
The re-arm hardening and the drvdata/attr-ordering rework would then be
Derek's, on real hardware with the hid-msi pattern.

If you'd rather I drop the patch entirely and leave the whole thing
(including the cancel_delayed_work_sync part) to Derek, that's fine
too. I'd like to land this fix if there's a version of it you'd accept
from me, but I defer to your judgment on scope -- I just didn't want to
silently walk away from a bug I reported.

Thanks,
Shengzhuo
