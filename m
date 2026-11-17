Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911799;
	b=aqdwOnX3kJD292Hcx/vx/JiVzmnqfS8B7Nu23wlQVhLSTYTEeEbJzg8L5FotbdQ8YKBO
	 feQCq+70ePbHA9E7y5bCvaNNPRSnCvmP7oLktVaNaS2VFX/QXKFNx933UcLgl1sY/7qJL
	 LLFQkKyyDduYmUq1I+qBpTDd4bDzFm0XQuu8ZB2SwGImx3sgXl0/dvbMPnKdvbqwyVzRu
	 +5UY8aFUYFPQyt0Em5u2u9D9lLHZk0Xy6n3Y7GrQOHUsQVj+iRt2gf2n5YVEADhbKOZPC
	 ADRD+WwhzS8TijFJ7WjDep8/pkGPPAoxhbd7CBIFA07n44yLERAd3pM2SIFM4dK2njA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911799;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3MNXyzkV7BpwCpVv/hJGI0Gwr07sz+o77clTU2h3Nqw=;
	b=4jIuRQxi5TopzDYAuiOjGCxYH2LR/OASAj0t8kf7eWgJJjGEzy8km2F6E7s/L8aeMzRI
	 Q4VSDkg2vkOjTxjK75FvKePcTNTjyyGrKkQqrR94vzAzS1MT9A7f7jLLHNwLXTlI3AKOF
	 stGVqWJOWeh5ndGDa5JTR1T4rDC3Nb+1ae0S5ju5/A5ugXIywnG0xs5J+38rH/LOQq6aW
	 B2svjZvJjwAfFM/jhKmOse/AleUTrrp9cT+P4eaFyj8TfSOUl3CC2V5K4rdFAmH3n4LjD
	 LLqUwZxBfvaUvSeB5AVwokDa6fHY/ZNr+xMxkfYwyu0rd9pCwUSaoHAGhJK3aVJEnkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU4gTn62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47435606A896
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU4gTn62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF561F000C5;
	Tue, 17 Nov 2026 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911799;
	bh=3MNXyzkV7BpwCpVv/hJGI0Gwr07sz+o77clTU2h3Nqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AU4gTn62wNU2ZK8FLWWrUKNOSVwKFEc5mxR4jZIjDnOZ/yszJWvlGDJ9oFPZXdMa6
	 aAwZZzi9L8VRmY9pri3osaUUtzn8d0PVhPVbWy/ZzQG8iDwQwwZMczYNngTfM/KAPX
	 lb+VRoO5IXrDhHPmvTXs9e6LFoDji7zpElJwTHLQezzxd3dnLREwsqkgxuufIsszQI
	 c964bee/PMpH660Af3r2Y3kXq55DG2BSpacW4T7dMi4bZtcos2Ez3LxbQM3WuSc/0F
	 vTIVavaW1Ub7UYgF1BfjMqe/w/p7XKlzcQiLm078JSm3LVYOW1VsI9PeqISTs9FS9n
	 5lh5DgTQfXnqQ==
Message-ID: <sashiko-outbox-218628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] HID: intel-thc-hid: quickspi, quicki2c: skip an
 empty read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117102726.271503-3-emfox@debian.org>
References: <20261117102726.271503-1-emfox@debian.org>
 <20261117102726.271503-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:36:37 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: intel-thc-hid: missing Fixes trailers for empty RxDMA read
  fix
--

commit 43159f2f56e537320c5a32041e1e942435685267
Author: Emfox Zhou <emfox@debian.org>

> HID: intel-thc-hid: quickspi, quicki2c: skip an empty read
>
> A drain ends when the ring holds no frame, and thc_rxdma_read() reports
> that as a successful read of zero bytes. Both handlers go by the buffer
> instead of the length: quickspi hands the zero on and its own length check
> then rejects the frame still left in the buffer, while quicki2c reads
> pkt->len from the previous frame and sends that report again.
>
> Tell the two cases apart by the length. A frame with an empty payload is
> still a frame, and quicki2c needs that one for its reset ack.
>
> Signed-off-by: Emfox Zhou <emfox@debian.org>

[Severity: Low]
This fixes a bug where handle_input_report() and
quickspi_irq_thread_handler() process stale buffer contents when
thc_rxdma_read() returns zero bytes on an empty ring.  Should this include:

  Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI driver")
  Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC Qu=
ickI2C driver")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117102726.2715=
03-1-emfox@debian.org?part=3D2
