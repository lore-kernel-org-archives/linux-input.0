Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5C35CB66;
	Tue, 27 Jan 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525889; cv=none; b=XtvJxEvqKCaVpWkxjufnE7qAx65yrbbc50PBG6xslK5/HEFNqRomnveQQvBeQq+jQTyY3rsyRN6oosTFyqsPwOcnpaHBPG7knROZFNH4g0vbuZbLAQ1btuwf6HdS6XDdP/ajy02129TZfHibxt6awrXxY2oh3r4IzLct5GTr9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525889; c=relaxed/simple;
	bh=mzWhPj6UqQR+JHQXW1dpXTcfpPQ0jvpOKlytf0zCpN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc1HF4fRBRhVepX/eit9f5oz/qqIfk2LsmtfAWFWQ91uY6mahR8+vXqZfo/HwCFbF6sfAz15Qj7E13gdIdklkgXnHlj3WMSR9vQNL7d4RKA2vvVzd84f2TgaBnmNnCSKx5fGcKXDOaSbtlWDj1aYPEQzaj/I3dD7M2yJ1rGSwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=dv39tFp3; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="dv39tFp3"
Received: from pps.filterd (m0341555.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R3xtoC2168300;
	Tue, 27 Jan 2026 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps1; bh=mzWhPj6UqQR+JHQXW1dpXTcfpPQ0j
	vpOKlytf0zCpN0=; b=dv39tFp3GSMZ56Da+W6r7DtSeHe3Da4X0/JKxOnhXY/U3
	1dKdZPw/jJskBGADczBZttuEn9vIG6UzWiJQB7lXxL9XKZcqGzPPdNkzjHoWJmlH
	DsnaluCkjqWQZ5SLBPObawHQrdsTWnFHOGgOp/2f1Y4UL7/jy+zs7acopVcqkepO
	YgFXOgnJLxTbR5mW/DIBjiHZuwdEju4FvRPeHRiBSfX0pUaUGdqTx0WyV9mArNQ7
	53unQAmsSTi2ASgxe8edJZS5LYaRd7A/hRghwgG6/nnt18LHVFueJFmTej3n4ORW
	hPkmsiXrw0yX74Dn1RyrdNYF6fJp/kf+suEpRHCFw==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bwcb144qb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:57:59 +0000 (GMT)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 6EDD5580C2;
	Tue, 27 Jan 2026 08:57:58 -0600 (CST)
Date: Tue, 27 Jan 2026 08:54:09 -0600
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v13 3/3] HID: cp2112: Configure I2C Bus Speed from
 Firmware
Message-ID: <20260127145409.GA3729183@LNDCL34533.neenah.na.plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-3-6448ddd4bf22@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-cp2112-dt-v13-3-6448ddd4bf22@plexus.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QvVTHFyd c=1 sm=1 tr=0 ts=6978d277 cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wykAuFGIeni_9ryPB6gA:9 a=CjuIK1q_8ugA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-GUID: W0T9irO-Jq6hcUWR_wknZWMj1t8Uo_Ki
X-Proofpoint-ORIG-GUID: pyDTDZTkUxojRj91bA8OetZ7yoeTHHmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMiBTYWx0ZWRfX9RFY28fzQs64
 GYf0Ur0r5zvFYLBYwKMP92jhQM3JD0dosT0El50GYZ3kz0tiYB8O/bBbRAbKUPz4mdp7jD5FFmV
 4mrL1yEqOvWiepJEYHGwTnNYQGXZoBiegifT6Y7tRC74LGQbDsVaPdp4o4SEIYEkEd8hYLws1ai
 rEu0cKcNEhDxVpF8bIyccj+ciP0jgBT6EilKuIaMupj3rR2HxQKD8fSwoTWHxM/ewBL0JzAeKLz
 Rk2F72lKEKxEMX4pkmZj3AmXeR0PeF+t9nVo2Cf+BIgZmv1nmwbfWMxZHLI2Rklq3mvKWtLJiCC
 80BfsAsP9NlsS+Z9oSMvK4qB3KaQ2aFv5IQStiGbeHHI2DkFmPYCOff7mqfJZdZ7ut4dMVgC9DB
 qHdUNXco/Gw1KV2sX1QCkFw8VujgMGZGmR5SP1XVD+70AH234CtStmZjuUw417sR8ltL8heXeVe
 jL+QhNzqnG8BXzPBp/A==
X-Proofpoint-Spam-Reason: orgsafe

On Tue, Jan 27, 2026 at 08:47:50AM -0600, Danny Kaehn wrote:
> Now that the I2C adapter on the CP2112 can have an associated firmware
> node, set the bus speed based on firmware configuration
>

Apologies, realized post-send that I never addressed Andy's comment
asking for a period at the end here and expressing his sign-off. Will
address with the next send if there is one; else I'll re-send this one
after other approvals.

