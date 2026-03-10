Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AC3B637E;
	Tue, 10 Mar 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161721; cv=none; b=kz5Dis1v9e84Wjp2/ZigJxkzXIyWP4pn9iNii7pbKDrs7TPKazSeoslZfYpUsijRY5FFdrK80Uo61nVW8Zy69uGefN9a1J+cleK8OdMaRdEuB/sOL+1zY5C1e492Onq3ssuSzQolWvvoNlKiGDpHVnZtulK80t8DTI1m3OENCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161721; c=relaxed/simple;
	bh=VHZgvCX1bkh1jPkqu7ZCoMK6C4dI4lVgzI4dnYB/aVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GFeanC7P0k9v7HJiB9LfFSNf/50XAKMM4SnLSv1fqkuSoAkZQxflRBp/D4q1BxiJNNx46ChBfkbEFcvz14WAND7xbIgIR7nwnSSZRNafZV9F+Ch/eKay1GlSmlE9IMXTo9eADArVtGf44RSYCS5Y2tu/eOBrsANcrH6U9eidlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyYBVG1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyYBVG1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA2FC19423;
	Tue, 10 Mar 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773161720;
	bh=VHZgvCX1bkh1jPkqu7ZCoMK6C4dI4lVgzI4dnYB/aVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GyYBVG1YmZnYluZmOQg+ZnxQ4LVKzjmumnSBWgVv52XemCZUiTYNlByekdB7flM67
	 FtCqmRgSq8nUlhc5jNnMr7rW4+064z5zLUpJpP4c4OSyfiqJgWrrw6neK5rDvaLjpB
	 vR10zPtTmGZbn3o+igXtY29hkLxqyvPc4Ayv4eqLRizk5/lj1F/Z5n8fQx2pfnkRlC
	 7LkYIMCmH9xxzLUYpQVhBRHQRdl23VYv0P+mlPxXl2Cjrd5hoGMZQHjfhKingfCxq1
	 9NJoJsmWvkaO80r5nzwK0nwwLVLsTlEPgc3E6Pt78wxAPRIbpI5Ws82McY4J7SmxR8
	 kq2bD6cQkzVUg==
Date: Tue, 10 Mar 2026 17:55:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Richard Hughes <hughsient@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/19] HID: Add Legion Go and Go S Drivers
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Message-ID: <90o4q991-op94-45o9-n016-4rs4s2n3n016@xreary.bet>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Mar 2026, Derek J. Clark wrote:


> Change Log
> v6:
>   - Include multiple bug fixes from Ethan Tidmore.
>   - Make all local attributes static.
>   - Invert the rgb_speed logic for the go driver. On the Go this
>     attribute sets a delay, so flip the logic to match Go S where the
>     larger number means faster so userspace can target this consistently.
>   - Include 3 new patches that fix formatting issues with v5 authored by
>     additional developers.

I've just finished going through the patchdiff and all the reports, and it 
seems that you've indeed addressed all of it.

This is now in hid.git#for-7.1/lenovo-v2.

Thanks,

-- 
Jiri Kosina
SUSE Labs

