Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86325616CC
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094557; cv=none; b=jNEm9tWCUZjKDOkEcJv3Xa5j8FoOm9rBEB7XPXJR5whKphVpo4su7yyDEpiJYztPCJ+WfqnXX/+OVK8xfdj/VEGx8xeNY9HDr7u7BYhOejo0QloUvJbCKRaCyqNhdNAUym1MsOkWRS43+ZMtX3C0zlmmSXoE0C948iFfW+/QFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094557; c=relaxed/simple;
	bh=l6shkSbRpYyzhvmDd9lc9tSaNrP+FhLW8ddk39435qI=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UAWat1ciYZHv2CMzjFcHm3G4eROYDNz0woWJvYy73j8JypUps4uIc+1ovBgC+ZrAkvhl7EmdAI/C0q9CkXSdQ/XT1kf+QBxZ0r1bUSVZHTR3iVm2MID/LN8k9s6Lak2VrCrH18nSnHwdTL/+MkLDHUfHQpismLH0/KlkDed7/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=A0ltI73Z; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TaDp72xg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="A0ltI73Z";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TaDp72xg"
DKIM-Signature: a=rsa-sha256; b=A0ltI73Z5OOd3sW3zl6CcsLUquRf7RodVvbTF8oin+D0IpLWcLmt8ToUZYQpjLYxR9ESfBikaVXLt0vCGjk23Ou5TBjFf+MXjBo3pPr9IlnCs1rRz8OahXEpFIMhx91BD4bkt55uzKgbc9LSRHb82DrN3Wr8cFWjlmwgfJb8uoV8JsrF23/7L5J/T0aOK50M07V1g3m2rmcIkp8/mCq+YtVis38/Rva/QDEQxEd/ng1p+3H0JYRYDjzPnfZEgSpbI/Cih0rzJ0+P3Zd4ZDJPuY8qc7KtmuST1AOjiAWxTLgMsxz6+Y9UxMw/wr6Nvwz+egwS6nbUkH609JPSL+EJVQ==; s=purelymail2; d=rcpassos.me; v=1; bh=l6shkSbRpYyzhvmDd9lc9tSaNrP+FhLW8ddk39435qI=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=TaDp72xgoppDBjzH/bxtG6gQTDr0oQlLP/9Lb+kSw/rRbuYGt5iHk63VpMRU91XB8bwAlgxSvpbgwhF4En02uCVzU/Z37BIHdjnpsDma+ZunE1WMbcIk6XSWEKhMjIz64eMT7993VorGVfO97sa8wpv3bzS0CPlbMZl/7GbFuP6939ZgeIBlHsN1j33DD1xYFEyyiicP0yiymJtLoqOVPCWGyG6frSXCR1mvbeFGKxwAohnP6NO+uE/FZJfbeqolnVasf3y9FCKhYKANSjVr0vFbQa134kTWXH+agKd+i34JbGSllLSScXJM9WK3uwazhooi++cylH0LTtYb28cTlg==; s=purelymail2; d=purelymail.com; v=1; bh=l6shkSbRpYyzhvmDd9lc9tSaNrP+FhLW8ddk39435qI=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 503822411;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 22 Sep 2026 16:29:03 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:28:59 +0100
From: Rafael Passos <rafael@rcpassos.me>
To: erikhakan@gmail.com, Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-input@vger.kernel.org, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, greyxor@protonmail.com,
 roman.stingler@gmail.com, lovekeshsolanki00@gmail.com, k8ie@mcld.eu
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_HID=3A_logitech-hidpp=3A_fix_hi?=
 =?US-ASCII?Q?-res_scroll_for_Bolt-connected_MX_Master?=
User-Agent: Thunderbird for Android
In-Reply-To: <1db23bb2-f94a-4bd7-b9b6-5175aca68ff1@gmail.com>
References: <20260904034843.1340846-1-rafael@rcpassos.me> <awkjflaaQZW7nPVUOsxJ5A@natalenko.name> <LYMlyJcyQt29e1KlLnEoLw@natalenko.name> <1db23bb2-f94a-4bd7-b9b6-5175aca68ff1@gmail.com>
Message-ID: <380DC9E1-7A2E-42E0-8D3B-0B17DE957B2E@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

On September 22, 2026 16:28:47 GMT+01:00, erikhakan@gmail=2Ecom wrote:
>Hi all!
>
>I believe I have an explanation (and a solution) for why everyone's resul=
ts differ=2E
>
>As noted in https://lore=2Ekernel=2Eorg/linux-input/20260920094508=2E3968=
2-1-roman=2Estingler@gmail=2Ecom/
>there is a conflict between the driver and Solaar in that user settings a=
re not
>respected by the driver=2E
>
>So while investigating that, I found some further issues with regards to =
how Rafael's
>proposed fix would deal with the case where Solaar disables high resoluti=
on scroll=2E
>
>Locally, I have a fix that expands on Rafael's patch and but also handles=
 low-
>resolution scroll events=2E And it also respects on-device user settings =
so that settings set in Solaar will remain=2E
>
>I believe that the reason for inconsistent behaviour for some testers is =
simply
>that there are unhandled states in combinations of settings in the curren=
t code,
>which my fix aims to solve=2E
>
>So, Rafael, is it alright if I post a new series with your fix as Patch 1=
 and then
>my addition as Patch 2?
>I'd love to have it properly tested since I don't have a Bolt mouse=2E

Please go ahead Erik=2E
I'll be back home this week, and will be able to test on my hardware=2E

Thanks,=20
Rafael Passos,
Software Engineer
S=C3=A3o Paulo, Brasil
