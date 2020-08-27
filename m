Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D6C433DF
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE44E22B40
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598520142;
	bh=kp+w8wlR74uDGEU6rRV8q7FJGgU/z3GY5h4GZ1a/azg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=jsRqNdstBHWBtE3en6Nk0Hhhxs5RRXT/Gl931EVTdlYa1IWmjzpt5JX3tBk0p9k8A
	 XoBilq0uPs3PwVu2XGQZdpzz+ArVwAD7FND4CkAcl69PTPMGneUjjsxLmw9L2Folcg
	 mkKKbg5lPJ3jcPPFTBp88OvDWA0xnblmsPXY7kzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0JWW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0JWV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 05:22:21 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B35A2177B;
        Thu, 27 Aug 2020 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598520141;
        bh=kp+w8wlR74uDGEU6rRV8q7FJGgU/z3GY5h4GZ1a/azg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ostF27jTWJYjqigVBG3QN8I8QjC2/pAR7PhgYkoFPVHpiNDMK4s1LVVH8VCdGoFsE
         LizldPeaLNxTXqnShIAIk3Vf6FHsWD8OauygsdJAgAJs8X93+9+jHQMjPN+oNOkIor
         274D4REoBDZ52Oj/pSXci8sSqkEdwk98BfV83uew=
Date:   Thu, 27 Aug 2020 11:22:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>
cc:     linux-input@vger.kernel.org, thunderbird2k@gmail.com,
        blaws05@gmail.com, benjamin.tissoires@redhat.com,
        Roderick.Colenbrander@sony.com, svv@google.com, s.jegen@gmail.com,
        carmueller@gmail.com, pgriffais@valvesoftware.com,
        hadess@hadess.net
Subject: Re: [PATCH v12 00/14] HID: nintendo
In-Reply-To: <20200823044157.339677-1-djogorchock@gmail.com>
Message-ID: <nycvar.YFH.7.76.2008271121150.27422@cbobk.fhfr.pm>
References: <20200823044157.339677-1-djogorchock@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 22 Aug 2020, Daniel J. Ogorchock wrote:

> I've included round 2 for the IMU support patch. The documentation is
> improved and the precision increased for the gyroscope values reported
> to userspace.
> 
> There is still the important question of how to deal with userspace
> implementing custom drivers using hidraw (i.e. Steam). I am resistant to
> having hid-nintendo completely yield when userspace uses hidraw, since
> that would prevent other applications from receiving the events from the
> controllers (like maybe someone configures a voip client to use one of
> the triggers as push-to-talk).
> 
> In my personal testing with steam, I don't see much issue since I
> introduced the patch to not send rumble subcommands when no effect is
> playing. Steam/hid-nintendo seem to fight when hid-nintendo is sending
> lots of subcommands (e.g. rumble, setting LEDs). Others have reported
> though that hid-nintendo/Steam are still fighting even with that patch.
> 
> I guess there's not much that can be done though to guarantee a
> userspace and kernel driver coexisting at the same time, since one of
> them could completely reconfigure the controller's reporting mode, IMU
> resolution, etc.
> 
> The two extremes seem to be either having the hid drivers yield to
> userspace completely when hidraw is in use (e.g. hid-steam with its
> virtual hidraw dev) or mask out exposing the hidraw device when a kernel
> hid driver is being used. It feels wrong to have things in the current
> state where the HIDRAW device is being exposed, but it's not actually
> supported.

Could you please elaborate a little bit better about this conflict? 
hid-steam and hid-nintendo seem to be supporting different VID/PID 
combinations, so that's not the conflict I guess.

Is Steam implementing some (proprietary?) userspace driver for conflicting 
VID/PID with hid-nintendo, using hidraw?

Thanks,

-- 
Jiri Kosina
SUSE Labs

