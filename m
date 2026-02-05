Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A23A0B0E;
	Thu,  5 Feb 2026 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297297; cv=none; b=AuREdRoMcJd3Xbqc2Ymc4B30o0ZueRR9RGd32jb5XznX6iKDNrrewd8o+/FECNm3NgeyjxWZ3A+MIbXdkYpS29iQJ9FSTW7MciEEPEzER+EDl+pfeP0zsKEq4YpH3CjN/0/U96JhrmOpjHMU7FEDmK5p+hvBB+iQarxhVlnYBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297297; c=relaxed/simple;
	bh=3htvrWmrvSHq4FuACoqH6sKFfh358sHMAnUwVycKdOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkcl/mUf1TAFMiYLHDT20LpZppVPs6r67noQCGoXfuhmNrlOS2pA33YaPPE/L5j4+oPoT6EYSUwva0fzPEux5qgjhQzQjTE0ZS3DniPICMO2YCxwdYI2OfuQmPgFqA7JhbHJh4qidT3SGPBB3vcQtBy5vqrJcCqtwNfk4JlIoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I63klihP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I63klihP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF0C4CEF7;
	Thu,  5 Feb 2026 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770297296;
	bh=3htvrWmrvSHq4FuACoqH6sKFfh358sHMAnUwVycKdOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I63klihPCmWsNlnLOg36ty9odqou8Gr2zf+I/KeqB5S5fX7g0E8CvHDlOv8cP0NMb
	 GZ9oUadCs1quLS+4vMS4Rh5UuBSLd78VVMV9a3fac3jMUn9HQ2zDCzIhnw0PO0MD/B
	 mJtYmpATWAa+ys/d390T40AEDnA63yx/3Hp8/6w7zeFEGnYYZ9zy2mJisUAWcvx5MH
	 tgbOns9m+3/KxGqAgeUqtNACbeuVoYkLb6FpbFQqfhssH6irOPrFTJVJeWImRFXngl
	 eSGwOARLl2dlhVMUSHeeA5K1jR3xVthZox/UzWUINN9vZ2rxOAE1G5Z2uBgHlAjOiw
	 UPnfpKnm/ifxA==
Date: Thu, 5 Feb 2026 14:14:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: input: awinic,aw86927: Add Awinic
 AW86938
Message-ID: <20260205-astonishing-aloof-basilisk-5c2acb@quoll>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-1-b51ee086aaf5@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128-aw86938-driver-v2-1-b51ee086aaf5@fairphone.com>

On Wed, Jan 28, 2026 at 04:51:13PM +0100, Griffin Kroah-Hartman wrote:
> Add bindings for the Awinic AW86938 haptic chip which can be found in
> smartphones. These two chips require a similar devicetree configuration,
> but have a register layout that's not 100% compatible.

That would be fine if I did not look at your driver which clearly
suggest there is detection mechanism. Reliable detection by
vendor/programming interface means devices are fully compatible, so
fallback.


Best regards,
Krzysztof

