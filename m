Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38735AC23;
	Thu,  5 Mar 2026 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755109; cv=none; b=Zfq1c7JdY3jpGQZfQ+MUhFIvGcubjhInfwEupikafxaBPkcAZ8P5J+SWhLsLZRZirhZBUPOood5bsUpCoZjb4RJXDkA86uIBP7/t8A2ca7mMl/svORKkjfMORKG6gCTnopCMweKBr8MjP6LuArTKFhDvJOz5b5XdkhBpzXe0OYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755109; c=relaxed/simple;
	bh=2gKfpnwQhZ8jFdRqSTyQbBJboNgsgqSqfE/Ii4xXCMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTakHbMyNWVBNXLGKtPc9JztpH5DomYZ1ar1upGHZdK8ilbtQT+kai+jmAHgo+PJa/FZJvdEi0i+a6G+dOXsRalKrTQDpgZQHrYFq3StRdhyc8L/FhtYiP2tVJFpqDd0ccjAo8KAzbTOSnmSyfEqdI/M0azlcSWc1g1dV+AXsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeffDpge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeffDpge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53077C116C6;
	Thu,  5 Mar 2026 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772755109;
	bh=2gKfpnwQhZ8jFdRqSTyQbBJboNgsgqSqfE/Ii4xXCMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeffDpgelyV7euk2SKfGM3zsvJgYW7llGVpY6zpoiRMHDlzHMMg7+6LvMk6jQblC+
	 QKBm6Nz5/9UbCo3WoFTDc4sVf5Fs2hnZqYcGKrsmmfWTxrxnX34wmlIS2VhtAlkQqK
	 I6bDiHfrsN8jZEfzSQjEJ5Ba3caWA3ENMKB/+XoG1bUnsPQG21H2Jv0+KwLv+UF/r/
	 5BTGdWMZGB3UoD1MQlnj5n/ozcM4LpFJAKCwGTYIZpHH7K9D6IXHNKMwz8seWp77Tu
	 T4rkN1QwRLHrYelbpqUKg0dziay6D50vQrBMb8eY7rqJSg1klHFI159LGzaLLzfqpK
	 d7N/GP6kFYFPA==
Date: Thu, 5 Mar 2026 17:58:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-leds@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/9] dt-bindings: mfd: motorola-cpcap: document
 Mapphone and Mot CPCAP
Message-ID: <177275510796.812517.12730527380740769335.robh@kernel.org>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223063858.12208-8-clamor95@gmail.com>


On Mon, 23 Feb 2026 08:38:56 +0200, Svyatoslav Ryhel wrote:
> Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
> variations cannot use st,6556002 fallback since they may be based on
> different controllers.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

