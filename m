Received: from mail.koesling.network (vmd143767.contaboserver.net [45.67.216.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873017745
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.67.216.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833033; cv=none; b=BahfbK8LrrzWEna9njKp642xam4I9lc/4VhnnwpPpV+j+pw52l0B7nvjaL5u3nhTqj9td7dFOlLoda05LA2vRm9zhEKnq+cJ0RQ8B9P0muT5E2TB+/GQJFhApJcwsMJuHnDetTusgCb6HsF4t1d0/1GU5QWBTgtc+GA2jEWR3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833033; c=relaxed/simple;
	bh=XnfcMyAyfWZ3ujGbIq4fibpgxgr65K7oxtX3hjKqAR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj+Kb6jkhL7/MMgK/h7LCHJXOt2WnsttMbuSpxLpoqBgDImGVqCBgg8oB6Ft1WkYoPxDeB/ZU+gW7N/MpQa/8op0kUw5LdnBzwGWiHw6nHTRUMvojiKBNAAdtGPuIekljW1ZQDhOCSXGrWzRXWSuiKWXA+PTEQd7ZynOU+f+g/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=OLB6g8Ej; arc=none smtp.client-ip=45.67.216.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="OLB6g8Ej"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D43171320E1B;
	Sun, 16 Aug 2026 00:30:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1786833028;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XnfcMyAyfWZ3ujGbIq4fibpgxgr65K7oxtX3hjKqAR0=;
	b=OLB6g8EjYcoLSPR9ZbpN/o6yxUWdg0bA6jNTa/ULqlys8Syw6bVi/AEKjln2kPwlpiBV+n
	xXXcLFq6OlFj/Jr8U0yH9ozyhdrZ+6PaYBIp0+lgbdiLy4WG7b819jUfyvh0dZ2FvrcrnX
	vQ9uMDm9+CPH3nHxpEJMuYlU1csqbv/UEm6pC+HEzgBfbeCXpIHaSMvIA0g2wkYzR74GWf
	9ePubeCYb4o61O0jueiXMGZ8iTZghi5zfLm8xaze74KBip6kABhIz8jbOTattvrejD2Apq
	50/5lz1P+IDnYxYTHETDvchIkZwRO7AbcZNqdcHxulAepk9h1fdKH7UOHPVtow==
From: Nikolas Koesling <nikolas@koesling.info>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH] HID: pulsar: add driver for Pulsar gaming mice
Date: Sun, 16 Aug 2026 00:30:26 +0200
Message-ID: <v3jxxJzxTkW08_xyeLPpAQ@koesling.info>
In-Reply-To: <20260813215753.4E2701F000E9@smtp.kernel.org>
References:
 <20260318205503.64420-1-nikolas@koesling.info>
 <20260813215753.4E2701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider: - [High] Incorrect teardown order allows
> `power_uevent_work` to be re-queued after cancellation, causing
> Use-After-Free. - [High] Manual destruction of `lock_cmd` mutex races with
> devres power supply unregistration, causing Use-After-Destroy. --

I fixed those issues in v4.

Kind regards,
Nikolas


