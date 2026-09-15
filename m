Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C547CA6E;
	Tue, 15 Sep 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465893; cv=none; b=dHAlJjMFxUisHlhW81x040C1mQArgXFrnKPScpUnN3/+phi4X7wSdok99q/fPYBmG/T4aAoaLt5yO76IKq5sMLMLuIiXGvkqbP8nDlgQl0ZWUq2glmsgIMevVdumtFyY0QW/PSE5avqs/FZrM733UoQ8gF0KHC3IHk2vrblZICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465893; c=relaxed/simple;
	bh=XSAH1l/hvusT0hS3lDTl1Sludph66OmEzZ+R9LSMFF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiSSMfbpzqNmBqa1lOFiAITxP6QpEqyubY9HcVTPh6jgxb3SjCouIX8fmlm+zut08A8Lg2oMVqt2zRTv4T20+T5EK09nmqEMXxaAs1BA1RAgYkD6UpgVjnP0ceuUPcS2dwardjyO7ZOvtG7p3MSBoFBytod/Eu4sgAwkyo/FgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=VuOIjqoI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="VuOIjqoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789465889; x=1790070689; i=deller@gmx.de;
	bh=xcQ/Ir0JwxIe+sMUqrjFHUZ8S6oDSraz0mqQ83Lss9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VuOIjqoInjQqFy8QuMy3KIklQiF6THHmJaZCjB09rV8uTEJQGoDpKhSXaq6JLDXK
	 YxGvt9HQO4k8sHg4HmxxS16wYv/rkz054x49mETF1xQRE4Y1axjissOJpIuPdGFAh
	 zn12inZh4i0TdWqfpRiiRWUSgTeu0axlUzfTGEALtVXLLP/6/smL4R5Dzsz5Qypdf
	 P8xROvFXSfjQuKZsmSexlu5Q65da7ZUd0XjpCkF77VlK7BpV3IKIOJcxBRDfTJ4pU
	 vApRk25w/gbcZgC/8ZT1hMKrpklO7J8CV+sJGnrfJEDgF0i19xxtzuqm+FPic4yI3
	 K5n4gDXVh2m818EdCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1wwHL20R37-00AHNt; Tue, 15
 Sep 2026 11:51:29 +0200
Message-ID: <4cc9fe4b-c3c3-46ff-a32f-d2a86c0ce077@gmx.de>
Date: Tue, 15 Sep 2026 11:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Input: gscps2 - clean up driver code style and
 structure
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-parisc@vger.kernel.org
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:giab1+Oj+gI7TOTSJhFWAnhw375Q+XTEX6Bk8w9wruvrfJ8l+Uj
 zfSJ1izKSF8KJdnnIDaeuDkF2WtGcCDrO9wzgwZLkphJllvv9f8+a68DuAWeDgXIfXKQ/yw
 p2Ap6YCzwqLe5vl1EGVtE8COsCp6OPq2+lXJ91FGCIFGFXLK28J4A6sTcZQ4rMUK7nVLaNq
 4yvJITjHB2vujNSe1iHmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g/f1uvD+5Gg=;80/WiX/hSPzm72I+L2faBNhxvsB
 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
 V0n27I/f/UnBtV3fn5E/hE

Hi Dmitry,

On 8/30/26 22:52, Dmitry Torokhov wrote:
> Clean up code style issues and function ordering in the gscps2 driver:
> - Reorder functions to place gscps2_interrupt() before its callers,
>    allowing removal of its forward declaration.
> - Change gscps2_enable() to accept a boolean parameter and remove the
>    ENABLE and DISABLE macro definitions.
> - Convert printk() calls to dev_dbg() and dev_warn().
> - Fix operator spacing and multi-variable assignment.
> - Add spinlock comment and use cpu_relax() in spin-wait loop.
>=20
> Assisted-by: LLM
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/serio/gscps2.c | 208 +++++++++++++++++++----------------=
=2D-------
>   1 file changed, 91 insertions(+), 117 deletions(-)
you may add for the whole series:

Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thank you!
Helge
