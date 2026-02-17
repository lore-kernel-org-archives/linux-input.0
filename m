Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329452C21F8;
	Tue, 17 Feb 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334701; cv=none; b=W8rMoCWhX0hU5perXGg3/f/zC08W3VjZSGg893sdvFJfK8aGGYM59CTgPiRXolGVGn1c+Gh7lTMqYGwUACDWhmzz7JpX9wN/kkwhNK803KNuo72g7Mm6B/86KFVEH1BChy69T+eYEu6+RMsZThEL6S+nz+lc3kbhTiP83lwByKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334701; c=relaxed/simple;
	bh=Joz5JlXAa3pM53OUIauwRiDJ8RLkMKbz7oKaQAkw4Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V1AmUkN1EYw8JCRgdAWVpgssRxs9r+mz7+6utiluwH/oAnFLe8F4TC/WPI90a1pbnWJnFIyS9X/fChkLgjuLQ0lrGVL9pyhAHecozaPZmYWQSr58Sz/VgagoBFg1psCimcJu26nM2lPKTM3hSgWx6pxtCkcjF5A4xKsR5/hsNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3cm5q24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3cm5q24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA22C4CEF7;
	Tue, 17 Feb 2026 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771334700;
	bh=Joz5JlXAa3pM53OUIauwRiDJ8RLkMKbz7oKaQAkw4Es=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=R3cm5q24Zf15hGmF/a0txpPigtF1GUsv8nrDqsCNSxkT77XgNBm9SwQPsV0TRDuW4
	 CFgESexhzGoL1qQDUZkqwWDwFYpgoO3F5vT4tIg++CKg4GonVoouZsuSLbcHocN0GM
	 8TSu9q+OIG6lXYkh7uNVThf0bkSVUarcnJs18frozMizCKYHPU85yTt2hYWHorqQYA
	 mMP1VDUIS/fQvymUjjLIw4GTXvi+fYwPKXDD78VpMcEXqDYhlxAEL3sHgt47mgFXd5
	 263H2lZCwaiNPAbvqhCVByzY3pw8Cxvz+LIM/a5mdreIwyi+6wZ3I+T3E8QC/vFRNv
	 w0mvWXdeWDFoA==
Message-ID: <1bfc539e-97fc-4832-beef-3056a873c258@kernel.org>
Date: Tue, 17 Feb 2026 14:24:57 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] touchscreen-dmi quirk for SUPI S10
To: Yajat Kumar <yajatapps3@gmail.com>, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0840e4ec-0b61-4e0d-9d67-d0eb2ab2d6a1@kernel.org>
 <20260217050755.16078-1-yajatapps3@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260217050755.16078-1-yajatapps3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 17-Feb-26 06:07, Yajat Kumar wrote:
> Hi Hans,
> 
> Sorry for the threading issue — Gmail broke my previous reply. Reposting confirmation below.
> 
> I’ve tested the attached patch on the SUPI S10.
> 
> The touchscreen uses ACPI HID GDIX1001, so no change is needed there.
> With the patch applied, the Y axis is no longer inverted and touch
> input now matches the display orientation correctly.
> You can add:
> 
> Tested-by: Yajat Kumar <yajatapps3@gmail.com>
> 
> Thanks for the quick fix and explanation.

Thank you for testing. Now that its been confirmed
this works I've posted the patch upstream:

https://lore.kernel.org/platform-driver-x86/20260217132346.34535-1-johannes.goede@oss.qualcomm.com/

Regards,

Hans

