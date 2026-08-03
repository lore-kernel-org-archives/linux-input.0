Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9B31B131;
	Mon,  3 Aug 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782193; cv=none; b=FfWEaDDChz2uAOs68WfhdM9Kb5mSrs3I7TvrGzYsR1+pp1xaiUbH4jtZ9O8M5odzwUO40L3B16eTxk6c969Mg+uycTkxhHcgOcp77AoirpgaRabqE2oeDzdUOfJY4lNtirlsZnIEt9B34wEbq3+VFWlkp8iht3OCcrLnudyB+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782193; c=relaxed/simple;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ugrlXwlP7C60uLTXxyAEt77ne9axuOePbgV3x9LlwQOlKb/kz9iZzRegegdqTSgM3VVwGR4oBRbOSP/1m9KjriLbQaYrz3wnXlHC41nZW7w+DfhfhryDGGmTFlJACHHFAjcP5iBdFnNU19vLiL67aMAO9zXU4Ojqf8oc4vCENw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuixVx3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuixVx3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E291F000E9;
	Mon,  3 Aug 2026 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782192;
	bh=w6luQyQlp43q7xRA222IbS8aYyAU4c2NFpr+h+0SaJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LuixVx3oM6e1XWH6XfQ1tk/1zmvE9sb0CLKBSDw4wAm/HVaZTwn3eIrPf4RB5YZ/4
	 MPqFH1mukRXi44fGUibUdeGPvIUMQOJDbNjrygjAZD6ZByWr1zoDQv6BkqwDQTAVAB
	 rDI6ISCKPzkoWB3xAR4D+TWPKRHi/EKuQZ4IJ5wkdYDDCYfJbpxp37pWNfF68Svvg/
	 N9c2cRfSXsbFMrVot6DBdhMIumcwVqrQEa8+Yl6ttIMliq02j4s6o8HT3IgKYVVVI8
	 dxGCFxI8Z8sXI8sDfZXkm0nNhmw0m93gbiMkUhdAPo6BNdtkj9Dr435umtuXU6++d6
	 CPlCDky6w2dHQ==
Date: Mon, 3 Aug 2026 20:36:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Elliot Douglas <edouglas7358@gmail.com>
cc: linux-input@vger.kernel.org, lains@riseup.net, hadess@hadess.net, 
    bentiss@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] HID: logitech-hidpp: fix Signature M650 side
 button timing
In-Reply-To: <cover.1783094954.git.edouglas7358@gmail.com>
Message-ID: <68365507-9nq7-sp0r-59n9-3q7193r1n428@xreary.bet>
References: <20260613175109.44365-1-edouglas7358@gmail.com> <cover.1783094954.git.edouglas7358@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

