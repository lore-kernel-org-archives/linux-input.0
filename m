Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A839023F
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094750; cv=none; b=HGPV4O1sSSTpeV8Zc9/h+DuIaHZEmWB/uT4Lk2S/vQs1lONSf4epWEnyOf7dx4w4pvPjYMBO5ydVm2JnpNdqUtPb1Gi88QFW+Jlhx8onV0owsjFn17lD1sf2w3Mfu+d/qqFM86W75DUZa2RsevWR0d8R4GnOQ9Jr0S2GdMoK7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094750; c=relaxed/simple;
	bh=6z0Czb7FP2nScHGh8cPZ+7GU2gIMMbvafFeLFQT/MBU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DLK8/FQV20qTkCWG2KpqMAvT+id3zMItBGrV6dyVr9dkhAudoVdGBXB438Me+F7Ig4owRlqbGPzwbC0V844rP+LFhLnhPIM1EjrfQhoIT58gSfu2RUWRCqsCZ05yBELkREXT+OVkLHWOgZF0CPBVHcPKh6St4M4GpIgCH0Dv5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=TTfXFtha; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KbPy8wNw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="TTfXFtha";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KbPy8wNw"
DKIM-Signature: a=rsa-sha256; b=TTfXFtha8pYwLLyYSVTNH+qs+Tc4hzl2O4CbUAr3NQoyh4MK9FWIJ0c1CQXpeDmhOndQTJCs1q74b4PTkLAzMzD4fHeGwL3DYEh74ogIGICNad45VummrSEsLJyV9cvlvftvS28ve5VKYnPRoh/AH+Zt2pBBiYqgdt5FbcCt7IpXiY07y80cBDgf50jvXId44B1JRPeg/+WGbse8Xd14DAqRtf9DQSic3YTzk0Z+IVuL+K6EX1ac6NXkGXzSGmeUCMKOZ5l/Lvw5bmKs0nTEs3xZCdtIH76Pdt98RrkVZkMpYMx/MqJcaFGtwaeKr/QFGKMVHu4l5ywjmF7sKHJeHA==; s=purelymail2; d=rcpassos.me; v=1; bh=6z0Czb7FP2nScHGh8cPZ+7GU2gIMMbvafFeLFQT/MBU=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=KbPy8wNwzuR3HkF2pygHAEfYueGNrHCLRydhABYuYceeBxQIOrIw3mJnqpIqyPo6RTP6870o+gEGUeHJxZ1FMCrEyHKF/pUHFNG1SMp2ejM6eWu9GRzaEEpfwe3+q8AFx0hyfRcOAUgJHfV2Bb1clA/BRQPkEWYKwZG/Md3VBc0G4ghmctjOJUgmAMtuCt3hVuSq9Cs4n0xnarQwMkjOVnIOtpgA2hQGxkPlqcNZJsnnmx3Zz8fUTObUkcReCb3WyLgKiPydfUnJyGcq47UaB0pQp/O8qiVab7xltLBl044rDWIKPCzEDxetdLuEyC7CpYR51zuXlcvSzuwAKSdAng==; s=purelymail2; d=purelymail.com; v=1; bh=6z0Czb7FP2nScHGh8cPZ+7GU2gIMMbvafFeLFQT/MBU=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1399263340;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 22 Sep 2026 16:32:21 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:32:16 +0100
From: Rafael Passos <rafael@rcpassos.me>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, linux-input@vger.kernel.org
CC: lains@riseup.net, hadess@hadess.net, jikos@kernel.org, bentiss@kernel.org,
 erikhakan@gmail.com, Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_HID=3A_logitech-hidpp=3A_fix_hi?=
 =?US-ASCII?Q?-res_scroll_for_Bolt-connected_MX_Master?=
User-Agent: Thunderbird for Android
In-Reply-To: <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
References: <20260904034843.1340846-1-rafael@rcpassos.me> <awkjflaaQZW7nPVUOsxJ5A@natalenko.name> <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
Message-ID: <F5F7038C-228C-4F8B-B0E0-BB470C8D2605@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Oleksandr,=20

On September 14, 2026 11:51:48 GMT+01:00, Oleksandr Natalenko <oleksandr@n=
atalenko=2Ename> wrote:
>On pond=C4=9Bl=C3=AD 14=2E z=C3=A1=C5=99=C3=AD 2026 12:31:01, st=C5=99edo=
evropsk=C3=BD letn=C3=AD =C4=8Das Oleksandr Natalenko wrote:
>>=20
>> For v7=2E3-rc3 + Bolt receiver + MX Master 4 mouse:
>>=20
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko=2Ename>
>
>OK, no, something is not right: the mouse behaved fine after a fresh boot=
 with the patch applied, but once I switched it to another device and then =
back, the scroll started to be crazy again=2E
>

Could you send the detailed steps of your testing procedure?
I'd like to try reproducing it when I'm back home=2E=20

Thanks,=20
Rafael Passos,
Software Engineer
S=C3=A3o Paulo, Brasil
