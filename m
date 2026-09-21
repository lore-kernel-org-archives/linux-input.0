Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2E314D1F;
	Mon, 21 Sep 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012880; cv=none; b=kUiFTTIsNp7DfGQr/orxYjjlNrE/IWAMyc0Bnh4zXbVFXXKHbEbh8E/lwVjXc0UptxaXAIL3prRxZcfudr2Hs76IRyCl65JULTQtQTaMaKChvxR6U5P9RdO/m4itjj456yy/AJzw4EODLKC2pM/22GvwxZk+4wKd1L6BVbui63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012880; c=relaxed/simple;
	bh=8kdqYhANjB0UawpPan6hzxU8m840875d1w+4D4I44Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udRMDEmLQwSIxKMuOLko3WwFSNTQwdhAwQdn/YZufPbn96SNksLTDony5zPplROHQziVcr3jOHongWa36/X3W7GGIQS+SroOGrappMMq4P+3EVQDVHM3DTSYwFZEbNJO44/aa/wNUvKdFDFsMSxz/nymnleDNmJeR6EvqKFPzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpwBDjxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpwBDjxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBF11F000FF;
	Mon, 21 Sep 2026 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012879;
	bh=HZmZlbz4mn8TDxPVxkZHX4aTCj3L1Utedhh4WQymMfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpwBDjxNT3lQVOjWs4SWoP3LoUpEtvFIcpPviDg2KJ2/BR4TShYl/zEM5fVYsltIW
	 NXFLKAWKvkny1G5r7wRBlD3KCjnxW347TSmt+pCYkb865C5r6lX/PPuJSA4Q907q73
	 ktedQOqR16kSzlEYT2VNpwCz/t++ymPGmpqWiw5dIpdUgaUZZFmijQt5bGv0n8kRqy
	 +rSb+3NU9SwDRUwyFhQLL5WWXFQTbi+4luTwcpD4YMtH59nYSC/EBBPy1/V0HKccov
	 je/rCDEVkIzK85TkyUuTXM/U4gh8bqyyUB4/Aa7D46lPgURieldkagOu4l2ivPEX7Y
	 u/iGrUU1MkHvA==
Date: Mon, 21 Sep 2026 12:47:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vincent Huang <vincent.huang@tw.synaptics.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: syna,rmi4: Allow 'panel' property
Message-ID: <179001287672.1068054.13463274135928403160.robh@kernel.org>
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
 <20260911-topic-rmi4_panel_follower-v1-1-c1b2cf1cdb62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-1-c1b2cf1cdb62@oss.qualcomm.com>


On Fri, 11 Sep 2026 15:18:27 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Many RMI4 implementations are present in in-cell panels where the
> precise power seqeuencing is paramount to both the display and the
> touch parts to function properly.
> 
> Allow binding to a panel node, which is expected to handle that.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/input/syna,rmi4.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

