Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AB396D1C
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677594; cv=none; b=rS+CtTjd17fd1bxTzhiKWbmANdavAAT7pLteOMZSKYdzYySq1iCCfu0rNlllWMzRwubyGgH2/mhjPu3tgtV9zEGGNjJuVeoeIdxM2OsSoBi+KSAYaLbGww2TYDBhjrbAsmnMGQKuc6YEBHuunzw0gVp/nDftsGEXS1oEBTkOyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677594; c=relaxed/simple;
	bh=+G8g8UbsAlGfYKnA1RtHQ8xGbsv+PS2SHbBUbIlLzu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/RAk1HvJE6N8dS7mNJqjM+GFPLZgSm7Ql29MCYaC8qXpPT9cWC+kuikuwUl/M+LdwfyEPZGeyyeaFXVj7CMiTwSOdcGsTTxuOJ2Hf0RDd7h1X+yhD59PhgmJHV22+3ZSjs/RDNZKKI7xGPVlxAhNB73iQtwIjBNZMSbRazMALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eppHxfgP; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eppHxfgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=p2iburaf55gehgofdeo5zov7vq.protonmail; t=1781677581; x=1781936781;
	bh=+G8g8UbsAlGfYKnA1RtHQ8xGbsv+PS2SHbBUbIlLzu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eppHxfgPgYMDv0HV9XbRdGf34oY7i8ze77+RKPrst6f2X0fP+MEgRUxcKYTz6WdXZ
	 Is2nZuX+XmMiQNruxY+GRXm+SeRW2hPJ3z1KTwkdWqYtuPVrbJhPKXZj3dvS0DrX6R
	 gLl1Oz2sVZYkziivfIZ9se/1yNtLegNybcemM8OnvtU3zzcXkv+XEpYb1OSWPVWOgq
	 9YuUU010KDYn01DniA8qhohFby/MOookXoMMkH8PwsRhfLUt83uJe/su1gBIryUluf
	 FgwXNBZkFFjoIwNGEtpbiJMMUuk4hUZ16uYF/L9uWcyzwrzdzobV8FSPkSsqyedtrS
	 043Xgquz/Zz1w==
Date: Wed, 17 Jun 2026 06:26:16 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] Input: mms114 - fix touch indexing for MMS134S and MMS136
Message-ID: <20260617062609.370312-1-hexlabsecurity@proton.me>
In-Reply-To: <ajHGfk7pCYltjOm3@google.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com> <20260616070529.156342-1-hexlabsecurity@proton.me> <ajHGfk7pCYltjOm3@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 2afee60d62cda3dcdcd73b52d166cc64a9d11cb0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 02:58:31PM -0700, Dmitry Torokhov wrote:
> This is fixed by the patch you sent earlier, right? It's been applied so
> I did not send it out again with the series.

Yes -- between the applied reject and 1/6's event_size indexing it's
covered; the min_t I floated is redundant.

Thanks for updating the Fixes: tag.

Reviewed-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks,
Bryam

