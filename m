Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD4301460;
	Mon,  3 Aug 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784090; cv=none; b=hudfDE8/4UVTjS0YyaD4mqrgu/nE5y1kDZMIraajninJliIBdHtLh79szp7NExP8cWcFPx6inpvPlZqVBNlKQq9Jc4H+J9IrSsNsboLRnrx1eW3IXgKa2QL4qbjlO70S0t6RAR1IUpS26Z0gUMruSrMSfqX4S176n90QdJL1TZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784090; c=relaxed/simple;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rAOploQhYWHb8rMUPoxytqk4+2iKCxcLJe4sn5ldMD1xmdNgL21vQV3MjnB5htLgHNj9ceuljsrE3wNj3FzFOn6YfXNd8fIax8RhFh3T5D/SRBmNgFUwFbd01ftvD559vXtwFspBhvFscl/dBsnJ4vjoEnv2gGTK4hwtG1HaPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYO8bgvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYO8bgvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7EE1F000E9;
	Mon,  3 Aug 2026 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784089;
	bh=w6luQyQlp43q7xRA222IbS8aYyAU4c2NFpr+h+0SaJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=TYO8bgvTGB/EsTYCCndJKGcT8n2C8NivWbCC5Z0eIYj4v6BiNyPV5dmgXOErkD3Tz
	 EEIMjnTQBbnwxclAGseOqIonXIujNbqMMPtF1MILQjDebrhF8G1ZFDU8s5amxkRBJH
	 WWTHIhKnMQYF+LGQYVDWLDR1ZBS/+3e3jc0HLWB32N6NNvgL3BGTuOUZg0m1J6bHXh
	 7Md55P5zKFKhJFeNBn8cJVAiDCkgiJjX3dYEScjluKPi4G8WwuV6tPOnJsJalKe4Sc
	 1wzC30gFvODE+y9R6vW7poV3gAAH5l9IJQDmtxgBxIXbYvn2nh1hPvS2w+xiNJ215Y
	 A6X5RgAV2nesA==
Date: Mon, 3 Aug 2026 21:08:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, kernel test robot <lkp@intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add missing __packed to struct with
 static_assert()
In-Reply-To: <20260709141202.5995-2-rosalie@mailbox.org>
Message-ID: <qp5qr743-74s8-3rn0-257s-0ps7n6007s82@xreary.bet>
References: <20260709141202.5995-2-rosalie@mailbox.org>
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

