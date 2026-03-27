Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F533BBAF;
	Fri, 27 Mar 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608569; cv=none; b=bF/S+znhESDb5dWSrypkzhlM8LHSdFSq2Sl8+edYAhIYRuhvcGpaSmmeTMBrZ6PPVehQ6PXHrvc39klc4ySoE/ctrP736tt924+2465ItF+qGY/wzlnY/qL1QNy+27nssGRgiH5XUn4YEI8nbytfwH1dwkQdrLlNqgxM2N5XQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608569; c=relaxed/simple;
	bh=bitapPgxqWOqMFhsgzAFD7H7x7NLEV9/HXYn2fueJpI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hHMmtyJVb88Af7x83jgDpdUjEUw/JlNupyKSBa/s5jb8L7GvMMnBD6HTFH+cxtesasQt4Sk0usIbutlbFb7s32BciR1Y33jmI51Tx1zzH0xImy/91aIStHz51o7g0QZg4jdsB90TIekMvyq9S7h63qYQrHmMlx4Aq+vVj7ivj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ46I4BX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ46I4BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A76C19423;
	Fri, 27 Mar 2026 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608569;
	bh=bitapPgxqWOqMFhsgzAFD7H7x7NLEV9/HXYn2fueJpI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uJ46I4BXG/VzYe81wxB/Gcp8N/PIiywQy/SiIRuMZylL/oelqauZNiPF2wYoGnf0I
	 1SBVwwt7w3GgnKu9afeXfIcLtLeUzrKlL0zMCG931ffGsTDsFBqy+uOu5sSxWTarfy
	 XFEDIvbu9XrZjQUD75NiJ/9LRDzieWecO6OwW+agC5pgSKiZE7HBU6v1OTB7pnklsX
	 hnFcBFVKhYgoRldA66aWNTU8EX+zZrfxMwVodwsSl64gdQPtKLgqnz3jSssEHCeTtC
	 Ma4FuijZImJ0GOz9+TZoYgTQHxplkQ2GeRMO0WNpMnSfOVLMDlLN3tRNKkgdqIetdw
	 jMrtudPPMzd6w==
Date: Fri, 27 Mar 2026 11:49:26 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sanjay Govind <sanjay.govind9@gmail.com>, 
    Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add support for more instruments
In-Reply-To: <20260228060552.53741-2-rosalie@mailbox.org>
Message-ID: <oq3n5s06-7r00-069q-qpp9-5450525n856r@xreary.bet>
References: <20260228060552.53741-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 28 Feb 2026, Rosalie Wanders wrote:

> This patch adds support for the following instruments:
> 
> * Rock Band 1/2/3 Wii/PS3 instruments
> * Rock Band 3 PS3 Pro instruments
> * DJ Hero Turntable
> 
> Wii and PS3 instruments are the same besides the vendor and product ID.
> 
> This patch also fixes the mappings for the existing Guitar Hero
> instruments.
> 
> Co-developed-by: Sanjay Govind <sanjay.govind9@gmail.com>
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> Co-developed-by: Brenton Simpson <appsforartists@google.com>
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied to hid.git#for-7.1/sony, thanks!

-- 
Jiri Kosina
SUSE Labs

