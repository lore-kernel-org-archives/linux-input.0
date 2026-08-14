Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87E46F4A2
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711296; cv=none; b=V8RbfACdNcS5syX6QOdrDLw3tk7AYq/Qjd++Ou6nuI/u/VgJFpjoDW0ucrNH4M2Oi/RgA39gdrQbSJ2D6yhEcbbs5L6xG0pwPRFkOb6ytIvUD09aYlOhP09icenb6Dj1Tf/mz0+IZPsaKR+JyilsbLkuCnF913z5NkQdvM0+e30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711296; c=relaxed/simple;
	bh=6o/eYFxvX1uQdGfeUvn4BeLcb4c0jXXf2KmIBlJTSCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tOgQmjJN3j8wGP1JjCUdOwhB/m9s+rX3ktrohy9mpFSuVJwNn5WjLc2EErlaTtYC9jDbFrYDuEcyyU4XNXQQzbknB2jrYtHm/SoXP3R3JxsdtdlEw9a+U2zWqo1e5utV3lgke+eya3O95ZXLoeSRtKntygLBcN7qQ8uZbJdOs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZofo13C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZofo13C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056DC1F000E9;
	Fri, 14 Aug 2026 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711292;
	bh=lG7KQaViTOgIz9tVs3ZX44ZxrI3yOpSm2+IKYDxngX0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VZofo13CSu6yAtKm+UmSv27Rl7AdBXix9Pqedj+TB70YSsrVEzjuDKbtnl3ifCDhM
	 HaaUEGgZeoyfZNeA34vP92VZ//sB4lghr99xmIKctrt/ylcVZL5ko305UFFFTjoyCC
	 1V8kl7TMTJuUIa0MgzUPWaY9FXjmKB0MBeDYi+X+7QyymWlQ94Ks4yKZ/mBqMoisT+
	 yaeZjHes2eHRD/guZCSYTVigcxgXc8mIVbye+gngP6HIxtJBcXLqGsk/OnjwfH36l7
	 sMbbPsEJE8oMX6iUYWynzPd30dwwsFSIsMy9ZFM1RotbDRrFGpOfoVlIxu7B/vzZ4w
	 SwnEeYZU1NFKg==
Date: Fri, 14 Aug 2026 14:41:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Uddhav Swami <uddhavswami@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: add driver for Gigabyte Aero vendor-specific
 brightness keys
In-Reply-To: <CAM94_PkKUuWD+L5pyZ6e36SgZYv9ObhGONQT22GP5EJxM=mLew@mail.gmail.com>
Message-ID: <7p12q87s-633q-qq00-300p-p7s2qs69q516@xreary.bet>
References: <CAM94_PkKUuWD+L5pyZ6e36SgZYv9ObhGONQT22GP5EJxM=mLew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Aug 2026, Uddhav Swami wrote:

> Gentle ping on this patch. Happy to address any feedback.

Hi,

thanks for the submission.

My only feedback is -- traditionally, we've been naming drivers in HID 
subsystem using hid-<vendor> convention. And Gigabyte is a different 
vendor :) Could you please respin this so that it's for example 
hid-chuyuen or somesuch?

Thanks,

-- 
Jiri Kosina
SUSE Labs

