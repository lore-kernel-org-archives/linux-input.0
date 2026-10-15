Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65144C6525;
	Thu, 15 Oct 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054334; cv=none; b=DYWRDnnokjcfFV246ABkOj1FOFe5CqQ7oyNQ4DSDt9Wz5qQXJurA7yWVpz1FahclUJa3L293hV74k6PsLXjJNUETbm4lUVJIs+jEAkACdk7WJmO+M5P5LtroRWpULvvg/uJDHWdPNSal73VHruyZWxz/dMRkEZDM7etl3G5FlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054334; c=relaxed/simple;
	bh=DGZOX7q95dKg1bNKWiFXfRt7xnds8rIB399lMbVunZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdwVODUzTLOgQxeczAcIXLQPCjstjQ8giPG3xy6HPzVAxclrlG4JpcC/BUHAGS/8f2csbtOrjXr1Wm/i/P5wStIZgs0+pO4vqdX2hCXgIEd3iVvhOW3u3L5zFNJ3q3aBpUTR999/HiojG9lENSMNb+8sQP2JLyT/7yT3SI2K48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKTJTA7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKTJTA7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E2D1F000C4;
	Thu, 15 Oct 2026 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792054330;
	bh=uDVJmLmsibAUI39jvyadaUkuu9QSWeyPIqt22YLl4c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKTJTA7ax157uQp9n2BkNzx+XxPXRDcxh7r92ZYsJMaeCYJe1cgZfGcmkmMhEYm+/
	 0kHfXrFVaT7uGlSnNg8/LqSIiJphTrZqN7DXjH+cTOrcgIfeTuN+U21ch/UI7EeCvQ
	 Q6OBlorOrNvACiCNt5iiQ4S+3erDv7Lj/W+NhKNs/bvQneJf84l15VJ6VkX409WZu6
	 58cnP+Ki4szHUTw5qJTesAvkzZJCHH+azulLjBTjO7lIBeiDS6hbyfUTfVfZCtf93e
	 GcucqHuXnnMh32TBVTekKVrenU9TsxJ8AZR1T8gItoQlRpMXp7CqQkPg1CMZHXq9M6
	 adSenK6xgaB8g==
Date: Thu, 15 Oct 2026 10:52:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261015-melodic-cooperative-chital-afa0fd@quoll>
References: <20261012-weightless-meaty-fennec-cdce10@quoll>
 <20261014134759.10946-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014134759.10946-1-wyibo6109@gmail.com>

On Wed, Oct 14, 2026 at 08:47:54AM -0500, wyibo6109@gmail.com wrote:
> From: Yibo Wang <wyibo6109@gmail.com>
> 
> Hi Krzysztof,
> 
> On 12/10/2026 01:24, Krzysztof Kozlowski wrote:
> > How is that possible? Same OnePlus Pad 3 Pro has different matrices?
> 
> No, and sorry for the wording - within one tablet project the keyboard
> is fixed.  What I meant is that the matrices differ *between* the
> tablet projects that ship this MCU, not within one: the vendor trees
> carry per-project geometry (caihong, the sm8650 era project: 2764x1630;
> erhai, the sm8750 era project: 2764x1630; iceland, the sm8850 era
> project the tested OnePlus Pad 4 belongs to: 2560x1440), while the MCU
> protocol has no command to query them.
> 
> Which also means your question from v1 is answered the other way
> around: the geometry *is* deducible from the compatible once the
> compatible names the project.  v3 therefore drops the DT geometry
> entirely:

I don't think we are describing here the MCU, but the keyboard, thus
it''s physical geometry is fixed.

Best regards,
Krzysztof

