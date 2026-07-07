Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5B2FFDE3;
	Tue,  7 Jul 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387657; cv=none; b=fSq1IMimmvctK/TXUrMzXfn3XtdsXTiJhTZnBCMa8TTAFDhSb1lruEmssWIifdTtOAM4/aDozAd5DIgG0lQFwztZcSx4dSMgjT2WFX2iCIUjw1bSzsebMFV6UCv+wWYv/7SeMH/BEzaeczZ72n98zi0eJlz72GYfvkJ0nfYHyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387657; c=relaxed/simple;
	bh=kni8+lO6N5E+laA2Hc7bOfG/j+KSwOIEn96kfYxITo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkQYPDClgLYnlBXH2ZfVOn2pmpdRfU8mirBl45gdlMspbNNc3QOtIxPpskF2LrUiFTrvuoRG59fVA8Fiq9vivbCjNrXJjw1almzRScX9Qou8qehXEyZbx3o8r+dIaOMfveEX9PoG8aFjcMkbH4HZk22yTdRhObNH2LNFEo50Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2qgSrNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2qgSrNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D501F00A3E;
	Tue,  7 Jul 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783387656;
	bh=HCkOFf4noYW2Oi5lHGy48ez1wOQdlsBhJaJd+daqKMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2qgSrNxmAmxs5jjRrLocOuSldR/GJR5DwPDZzKF2RF/lpjp7VJcXAElLHi82IYfj
	 ruzruuIIHCo38VusAgn1MmnhL97FnlwHdMJfiX2wL1atyARDBAFllFCgP2+dVo6lAx
	 9pxSaFrCOU4pxljyVge1fxBfKFVlS8kM+7yR7+FnGJ71dXfRKwJWU+oCa4UINRwZlU
	 4E9Mu11XRQVUnyF1he9iMk9TWdVQ+f6gYrcT/P5V9Or4roPf7D6UqRdxOGQgK43xb2
	 ahuDto+QOPDQctFR57UWQxVaa96lfQ48RhGcsNXyXXWLJbMwcZPReSIvWJ7UiMpWTb
	 7i4+A4BuF1cxg==
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Vincent Huang <vincent.huang@tw.synaptics.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/2] Introduce OnePlus 6/6T touchscreen compatible
Date: Mon,  6 Jul 2026 20:27:18 -0500
Message-ID: <178338764545.1558388.7968899731538373474.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523-synaptics-rmi4-dt-v2-0-0645122babdc@ixit.cz>
References: <20260523-synaptics-rmi4-dt-v2-0-0645122babdc@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 23 May 2026 11:45:33 +0200, David Heidelberg wrote:
> Mostly related to the
>   https://codeberg.org/sdm845/linux/commits/branch/b4/synaptics-rmi4
> series, but independent on other changes which I trying to upstream for
> more than one year.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sdm845-oneplus: Update compatible to include model
      commit: cc8748ed4da16233d5b3f27e86a412a991645aed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
