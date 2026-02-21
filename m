Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE2194C98;
	Sat, 21 Feb 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667459; cv=none; b=SU2zFFuhjxl3rH4APDjCiyC9g/eFekTTmJCufa+1KKfbgALmbR9QxlNV99AkHC3f5CucqZmPa2ydX72fvOEtWRexM3z7dpNzzUZwZpQlmeMM+PMXIufrlUKBoNaVU9m2mBzj5NrBYCBPHeDrRys6dlTxdtGGsSDO3ZukIwt+Iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667459; c=relaxed/simple;
	bh=oPSR6okcFq/O7c4Pvk8OYWzntDAE3ECvyeIQDQ1Wzb4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DCTY08KibeD71n6dwC8Tbjnd8zwkN8aHDmrnTKPipjhDHQaaGlkLCnzJ+/0IVwRa1wtc359By+hAp0H6cpiLjzURnvAKqQqlT7cSTFP/yUGMu2+6l7USB2lGPUMakKd16tZrhlZ45/oEhiiBrxSb5Mz0mCzLDh9xJ/+pQOwrRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaUT8q+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaUT8q+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F9CC4CEF7;
	Sat, 21 Feb 2026 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667458;
	bh=oPSR6okcFq/O7c4Pvk8OYWzntDAE3ECvyeIQDQ1Wzb4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oaUT8q+7Hf4FXj27jUELT8JyzYyoJdQrLNPH0BloAeWGUrXbyS7ct2UomFniIMOCs
	 tgHoNxukZN+B3e9sTKss5RuFsqTmgw9AyGgQtWvrdBOj90W2ApmT5eyyZssrSYmD8W
	 eOiWTDwIr1DFwI0mu09qbJbmC9qBv2OxaVwiz3rpmM3A2U4gGE6o8ldcVCAQhp5Oh/
	 HhJAvGT+AKyJ767gp/IQwhOkPxznrf8oV8TFM7725K091J4ezOR1rz7FsGwQz6mR4P
	 8Sf+n/eY9xmKyPAX1ENLnKDfbL0xe50o+oWjwMf0km2dvizxJEko8LAGrJRILV2+BJ
	 Uradwsbew+NPw==
Date: Sat, 21 Feb 2026 10:50:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Julius Lehmann <lehmanju@devpi.de>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: fix battery reporting for Apple Magic
 Trackpad 2
In-Reply-To: <20260214-magic-trackpad-usb-battery-v1-1-353bc63b56c0@devpi.de>
Message-ID: <qp8218nq-6r64-73s7-7069-03432rpp4po1@xreary.bet>
References: <20260214-magic-trackpad-usb-battery-v1-1-353bc63b56c0@devpi.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 14 Feb 2026, Julius Lehmann wrote:

> Battery reporting does not work for the Apple Magic Trackpad 2 if it is
> connected via USB. The current hid descriptor fixup code checks for a
> hid descriptor length of exactly 83 bytes. If the hid descriptor is
> larger, which is the case for newer apple mice, the fixup is not
> applied.
> 
> This fix checks for hid descriptor sizes greater/equal 83 bytes which
> applies the fixup for newer devices as well.

Applied to hid.git#for-7.0/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

