Received: from e3i491.smtp2go.com (e3i491.smtp2go.com [158.120.85.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B05632AC
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094823; cv=none; b=jnuteXrmEA/Xxc02knEIuspWzwyWMcpryNHnAXo+C2Y11MpWIbRlhYGeq3ki+jbPjqh1vcv5GM9rqa3v2uSMG5Cw7Ol82JHzlcJTWL4FjaZOePlYIDYx2sZo8t/FFde+PzRmYEkdpNuVUJHWdvafBc+YvjMEdpdgKCDZLUL+eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094823; c=relaxed/simple;
	bh=WOIwRVktSH0zmJi+wu/WNNId1XKCOlIwF37uFeGMi2Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAOcaMtr6PhFQxBdsewgPte66L6yxpcfDiveTnswCkrLUm5I6hnvPmT4AYsxgCn4BjvnoUij+9VvsBIEvK5Hmiy52UHaLe3WOqeJj/iO1VxKvqnVO9UNo+m71NDezVsaQzd4HXdCMHYnGdWKf94VEnR9x0JNpFw25iYczD1YsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev; spf=pass smtp.mailfrom=em1020969.fkr.dev; arc=none smtp.client-ip=158.120.85.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1790094818; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=WOIwRVktSH0zmJi+wu/WNNId1XKCOlIwF37uFeGMi2Q=;
 b=Wsus2idIcnzveckw4Y21AUDH5OfpSX65EHQjoCSw9gFaa4PDU3EoG3Rzw/poDb3hPMgoV
 86maITeByepmiUKuov/JRY85hzw5v6U73odaOiz4hV97GfnrKadIIfRXK4/HSNCnPTShXN0
 q2fFmTXED9ZfSwZbm9jezLA9mU/XahaE20KYhm/B28GFydS7PSHt3E8hb+zIy2O1HrTXDyI
 hl5cweE830hIEGrFIMYvxibN2Svouyf9+/vR9j/J0SdHrYw46RRrJoKcZbBCIYsmelgXeND
 WazIJw6k+6ZTASAsdQdFZX9xZphqkjuKVizEfGR+n3wxz7CEe+uyiuYfk7Uw==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1x93Qm-4o5NDgrgXO7-nNxQ;
	Tue, 22 Sep 2026 16:33:20 +0000
DKIM-Signature: a=rsa-sha256; bh=WOIwRVktSH0zmJi+wu/WNNId1XKCOlIwF37uFeGMi2Q=; c=relaxed/relaxed; d=fkr.dev; 
 =?utf-8?q?h=3DSubject=3ASubject=3ASender=3ATo=3ATo=3ACc=3ACc=3AFrom=3AFrom=3ADate=3ADate=3AMIME-Version=3AMIME-Versio?=
 =?utf-8?q?n=3AContent-Type=3AContent-Type=3AContent-Transfer-Encoding=3AReply-To=3AIn-Reply-To=3AIn-Reply-To=3AMessag?=
 =?utf-8?q?e-Id=3AMessage-Id=3AReferences=3AReferences=3AAutocrypt=3AOpenpgp=3B?= i=@fkr.dev; s=default; t=1790094800;
 v=1; x=1790526800; b=chcCnP+/d5P/3bmsY9LR3KqX12bMAQhn5FF06XlFWKNgXlE2Q1kXhVMm8Gt5VXK1WwOVuc3q
 io5vM7f9UOYQBJTFGd9BBYdS1F0jGQIgyA8iz1h6XBMKu34Mh4lFSW/2oZmZi4l+oT4mqxTkeF3
 kp90ix5WXj3wUTHDNxqzKiOSPY0n79gA3RjXcSA1nAQ/MpdUGOTkEIaLnYyj29c5579C8dYD57r
 S076F2Jss5E+8hm0vyONOxFTlVFCvDFhcuS9PnDQBGFP3JnJoyqRtQiNrDkSTwvzLksvjEdq3Rx
 I86Tc6MCgFMTFiRWOCO8JR7Dv+FvyKTKMJNkPQlFOfylQ==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id 44495b57; Tue, 22 Sep 2026 16:33:20 +0000
Date: Tue, 22 Sep 2026 18:33:19 +0200
Message-ID: <dda42a33a67da0f347de28d3bd3738fd@fkr.dev>
From: Florian Krischer <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 fixup 1/2] mfd: asus-transformer-ec: use 8-byte event reads on SL101
In-Reply-To: <CAPVz0n13hNPrZ4NKxindNQRdCbM28kyj0UDSarqzd35DEpny5Q@mail.gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com> <20260921175234.3137985-2-florian.krischer@fkr.dev>
 <CAPVz0n13hNPrZ4NKxindNQRdCbM28kyj0UDSarqzd35DEpny5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969sBKYKfHSeC
X-smtpcorp-track: 3f7176u_S5JQ.8BskD_WiplKA.ZSsoPgZ0lMa

Hi Svyatoslav,

Yes, that works for me. Passing the entry size through asus_ec_chip_info
sounds cleaner.

I'll test v11 on my SL101 when it's ready and add my Tested-by and
Signed-off-by.

Thanks for picking this up!

Florian
