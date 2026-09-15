Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E9445ACD;
	Tue, 15 Sep 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500919; cv=none; b=KOu+ZpiKT/jSzWIGPEmlHLndBQXhxyfwfgy7YofQSm7cPIixGgR++VHPw9LP7ovFpBOnm1wCNjgrB9+0SRHA3gfjPocla8i1xf/mu8ulSX9CUgvohOolZADLf5aDmtbhaOg+rtnpKRY2PF+LZ7mSanQQeuXiU7dfaTyhwBCHpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500919; c=relaxed/simple;
	bh=9Un4DjyPCqUWYYUkkqI7uLg4bSqdlekZ7fD3aSQwaeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IicgDXbyOFufSYzL6u07832Ti0wD6jF80+MSlrRy5/LerDTF5d3Jp625EugfLTdyU++jA1DMC7+CxnKlX0G20DrSMys1Cd/9OaUxg88lKCc0NYOJCYaq7eHf8npHJD/JYeOeF9G493alHofTif0tJ1/2Vgy3MP/ZNCo0FUvFGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ziq55x63; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ziq55x63"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9747C408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789500917; bh=+xCLCgzzP6ln99V44WGF+qnJUCTrrG2BJFVPOk7GeEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ziq55x63vqUw2+G37yu8UG3P0g6sD4dNT/SYLWYm7t69Gf3z0kGlbvuNXTAG5nxgz
	 024jOk71Xft9v57GbVupgBqdNCOeRbRkyQ0q/rJyKh/duqEhTF1/I263slOmKOawgt
	 LpF0AF6Aoc9d1ushkWJAhhObz6icsSUGrnNXLi9VwJ+U0H0jFl5sdi3SdncmUkKZbo
	 +Qhz4ZlyVBZ9D1Z872m3MSh14iZYdRXt5C+eZEQA5gvMgcV1bvBluAAG9LFrzInMC8
	 zesaA4S+4rhWQsv7C2wSZY1R5ji1z3Q/MuM3Q+oIf8vhvObtYZ2JvX6JuPr2J9zWad
	 GQCqMXT6Nhn4w==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9747C408B4;
	Tue, 15 Sep 2026 19:35:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebnerli@mailbox.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: input: Fix bracket
In-Reply-To: <20260905074142.810529-2-manuelebnerli@mailbox.org>
References: <20260905074142.810529-2-manuelebnerli@mailbox.org>
Date: Tue, 15 Sep 2026 13:35:16 -0600
Message-ID: <87zexi71fv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebnerli@mailbox.org> writes:

> Add missing '(' to C snippet.
>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/input/notifier.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/input/notifier.rst b/Documentation/input/notifier.rst
> index 824379399..e7facd1a1 100644
> --- a/Documentation/input/notifier.rst
> +++ b/Documentation/input/notifier.rst
> @@ -31,7 +31,7 @@ In a rough C snippet, we have::
>      kbd_keycode(keycode) {
>  	...
>  	params.value = keycode;
> -	if (notifier_call_chain(KBD_KEYCODE,&params) == NOTIFY_STOP)
> +	if ((notifier_call_chain(KBD_KEYCODE,&params) == NOTIFY_STOP)
>  	    || !bound) {
>  		notifier_call_chain(KBD_UNBOUND_KEYCODE,&params);
>  		return;

I've applied this, but this document looks beyond obsolete and in need
of more thorough help...

Thanks,

jon
