Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A430274D;
	Thu,  6 Aug 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022559; cv=none; b=rDxzYdTXFzYPYLmn7VjJiYRuiNs137gzEC5Oc++quwGf9rysb7m0SN+15qBuWAfzCYkfQPCdYjqRjomRKf+pcjnurrShL2cm6vpI2sdhcVVcJJ06GOT0rcfFMg+CsJoJW94pttlrPt4qpSkJk6qJfoK3u6Zj3BEVswALwUv6BuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022559; c=relaxed/simple;
	bh=3mDhapA//cgyK5W3iYLN+67BA52+ATVQ+g800Monzlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AEtojWtux9ZGl8U6lkMtg3GRiE6UevHcD2O+PpGGfebKodWHvLW6KeJbLC3F/Jz+aD2dWQP8Sgn68fJyuaMnP68K7L+z15AgJxiqYzcb3s1BRVLAAIIoyzny3I8YdgUOKJqRkiwLx6diHQ5k+DLcjQhV0EueCbUHRXKSHjIsSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8/OnvO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8/OnvO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CADB1F000E9;
	Thu,  6 Aug 2026 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022554;
	bh=pcM3zdhwG0lL8+JjtHEptuOJnNm6vBj3zLpYYw+ddU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T8/OnvO5ueBaRDSRAZkO48/nOPN8k8UaVYcLqne7i26Fc3wUkS6oGKSSDBPdDH47g
	 aKs8KNlEMpVa5y9/KK7LqHAY5FqhOaVcFvcs2RUxcQ+v+q0Px9bpnMJ9cDcxVGaK3x
	 HO9eTniLQH83fzwenLO118mkaCQwhneqbEVqHnDb0Kkgu5/GnU4oMYzQaJZyrj3r0z
	 mWY/phQB7A8thexxeSfOjh1g4YSxy8TbUhc0urTrgNlghM8LHtmx5zgUOAaI9+evNy
	 JDohb4cvrAqSlwMLKW/HyNfWbmtrWcY9NjumWfmIhIPP+mg5Q5fC5gzckWHJ979GhL
	 AdI6c+FDbof/g==
From: Lee Jones <lee@kernel.org>
To: linux-arm-msm@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: David Collins <david.collins@oss.qualcomm.com>, 
 Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260804-qcom-spmi-haptics-v5-2-77128ebbdd2d@oss.qualcomm.com>
References: <20260804-qcom-spmi-haptics-v5-2-77128ebbdd2d@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 2/3] dt-bindings: mfd: qcom,spmi-pmic:
 Document haptics device
Message-Id: <178602255123.2917765.7426706813083510078.b4-ty@b4>
Date: Thu, 06 Aug 2026 14:22:31 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 04 Aug 2026 23:18:13 -0700, Fenglin Wu wrote:
> Some of the Qualcomm SPMI PMIC has haptics device in it, add it in the
> device list.

Applied, thanks!

[2/3] dt-bindings: mfd: qcom,spmi-pmic: Document haptics device
      commit: f5071235a1621fc8c8f6c513252028b0858faa9c

--
Lee Jones [李琼斯]

