Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916C449B3F
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723301; cv=none; b=H/QsssRF9e0Zc/QqKUU7cf7LPhdwWPTCiBDuYMN2SZ3ynyLuhg1ly6kpiM6iaQUxrL5N+I0pICqL8PxoD3Ryknf3Vw5d/w5uPLyHsVDje9UjEgBBfw6DsRo3v7MnZ5B3FzSVU7EGLFBl0J3Cvi/xFu1jLe244KDd6i8BCWrioU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723301; c=relaxed/simple;
	bh=VHyARekaathNQ5Zci7oOBsg7sj2Qlf9OcQZbK7UdEsw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=p8nSd8AaTVclKPNTqgxS2LJrx68AddVHy79HwsM3DvaY/6hgyjtQN27q2jEBi7BwI57o+aQXjT5cOx2UwX18wW5k99kkmiIakoP/HD8PJ/pXQ9gTgZI/YGmj21isJxOI8waRdy1vmSbD4NpdPzPg113Z5EAUb0RppQSqOL6Uks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=C4jbCrFE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fjn9nKcy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="C4jbCrFE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fjn9nKcy"
DKIM-Signature: a=rsa-sha256; b=C4jbCrFE/W12TPc1ILoUvwd+datRx7yDbFEc6sLiaaFu2kWECpnBn7Jlvsmz1FJcLt4ZbAnBRZuvx72djY0ke1kvTSBYe+OtBsNfJiu8kXwU8yVvso60ElYJ93wjPO6BIFlKKJIiz7tH6e7+xMeUxntX2ihXz0PB3Dns1TwVbQlNLUQiO9oyMCvI901yrYYW/2/V8BZZrYOlHSAcX5jjpBODSesHnBnTIWczeBQOFKqDrdhnPRsBHpceG5ujfTfKlQC/S6SfbOt/aKoWlpDMh7H6ysaJ+ztYZ/uO52UVMmB4ULgvpmdjAlxwBbfopJvo2jBa/7DKqp56JFp8o2KgoQ==; s=purelymail2; d=rcpassos.me; v=1; bh=VHyARekaathNQ5Zci7oOBsg7sj2Qlf9OcQZbK7UdEsw=; h=Received:Date:To:Subject:From;
DKIM-Signature: a=rsa-sha256; b=fjn9nKcyS5XDM6aVmVm28CAnUulrTLkrAd4UBA7ClS97y49iHL8HgD9ZuYGbHX3EdBiA3Fut+Q2W66tWyB+NegxQ/4Dn+TNmBNJMMC58U0ug3AoIbN6MxtZndfRibobODAdHxY+Rfv6NlRXvrSlzsP4qQ9wutZuihPvIvuSHpJqrEFMYKtNgufaHC8oC8bnSNidtW/J+4i/D+ujnuk9qGoq8b2sTTdWEOshbOgLQDBOs7fp4cZS+gv06Eh0mPwo0A/NDQ+dgG+l0UIltIMbLQoJPmfo4O+MDmGyveed8ATP2BxV7jEQD3vGdfb2IcsYZhPP3JS3fUTrYLnZhlq+2gQ==; s=purelymail2; d=purelymail.com; v=1; bh=VHyARekaathNQ5Zci7oOBsg7sj2Qlf9OcQZbK7UdEsw=; h=Feedback-ID:Received:Date:To:Subject:From;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -581114090;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 11 Oct 2026 12:54:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 09:54:55 -0300
Message-Id: <DM20WF04H7JK.2HBWS4KGUBW19@rcpassos.me>
To: <sashiko-reviews@lists.linux.dev>, "Rafael Passos" <rafael@rcpassos.me>
Subject: Re: [PATCH v5 2/3] HID: wiimote: replace spinlock pairs with
 scoped_guard
Cc: <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
From: "Rafael Passos" <rafael@rcpassos.me>
X-Mailer: aerc 0.22.0
References: <20261009022844.2790778-1-rafael@rcpassos.me>
 <20261009022844.2790778-3-rafael@rcpassos.me>
 <sashiko-outbox-164733@kernel.org>
In-Reply-To: <sashiko-outbox-164733@kernel.org>

Oh well, I dont know how this happened.

I will wait for reviews in the rest of the patchset before sending a new ve=
rsion...

On Thu Oct 8, 2026 at 11:44 PM -03, sashiko-bot wrote:
> [Severity: Low]
> This isn't a bug, but could we remove the leading spaces before these #in=
clude
> directives? The extra indentation violates the standard kernel coding sty=
le.
>
>> + #include <linux/seq_file.h>
>> + #include <linux/spinlock.h>
>> + #include <linux/uaccess.h>
>> + #include "hid-wiimote.h"


