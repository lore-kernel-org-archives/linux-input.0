Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B739264FBD
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664914; cv=none; b=lBPqRvlkl9VshS/A25KE+xiBf/u/F5xuHtkgL91EZjmqgLZJBbFElmWwijU3ccN4oN1so1fkUDyfVr+OfEeyg/10YtIujoMiCsd3HjJawLu+afc9bVHhlMZfJHSRmIRfzjvmO6nWhAjW8/bIp6ff2AYzVmyY2zcfqEP8L32GtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664914; c=relaxed/simple;
	bh=YHeiE31POekDgI73EKM6sQjWOGSsGsw26HePHEqfD6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IXCdRI1qpWQ91HP4sSE32dUxCEDtUC1juMTe4oY2VgmgROEmilk7ab87M1kCk11T6z87BUgjfQ5hV/OqG2zqP60Bwgr8Uk0MkZCjyYjaDO3aeNO0tstfMq6eExJMdxEGpH/HEwVaVsmQvYQZMR98RdeQzM1iY13tDpIrDIPgrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QitOchLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QitOchLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75DC1F000E9;
	Sun, 28 Jun 2026 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782664912;
	bh=q/Rcs2nYBVaNfNEU/yjb9cALGP/Z9sdqb3yRZDnva24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QitOchLtyxPJ7D6bJu7MHZZMUgBRQtOXD4sFOJgYf9cKd6c7GOjE/tHtQpeSVaQFn
	 0p98MKupYpsPpuvJPYF+oGD33cocdgjdJARoApGzgOb6vx8FZo1Id87Tg6Mv0Spjx+
	 Hr3mJK+RclO3Ht1t7qKHkcgaXb6/yrbKLp6bI5Sbz/lf4KUHnPL0NiTU4z/fXDKhu0
	 a1KDCjxm3UoC32FvTJK/LBdPtCS8vLIcy0d9mZhepn+ej7AAWIRcqm67RsoMuJlK74
	 H6iS8ihnBjeu08PRuz2R8us0Hu5N7epIJxFd+fK14l7RdEzYlVgDQn7afAlEDqCsFc
	 NWwFrwY3PS3OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: pxrc: reject short input reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628162806.10675-1-alhouseenyousef@gmail.com>
References: <20260628162806.10675-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:41:51 +0000
Message-Id: <20260628164152.B75DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete fix / logic error: returning 0 for short reports does=
 not drop the report.
--

commit 601e7ac29ed99f9b83b5ad4f7ade423528b08e79
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: pxrc: reject short input reports

This commit fixes an out-of-bounds access in pxrc_raw_event() by checking
if the incoming input report is shorter than 8 bytes and returning early.

> diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
> index 71fe0c06ddcdf..e3755d8b85c22 100644
> --- a/drivers/hid/hid-pxrc.c
> +++ b/drivers/hid/hid-pxrc.c
> @@ -55,6 +55,9 @@ static int pxrc_raw_event(struct hid_device *hdev, stru=
ct hid_report *report,
>  {
>  	struct pxrc_priv *priv =3D hid_get_drvdata(hdev);
> =20
> +	if (size < 8)
> +		return 0;

[Severity: Medium]
Does returning 0 here achieve the goal of ignoring the report?

When the driver receives a short report and pxrc_raw_event() returns 0,
it signals success to the HID core. Looking at __hid_input_report(),
if the raw_event callback returns >=3D 0, the core falls through to
hid_report_raw_event(). This will zero-pad the missing bytes and dispatch
the report, which can result in erratic zero-values for the missing axes
in userspace applications.

Should this return a negative error code (like -EINVAL) to ensure the
malformed report is completely dropped by the core instead of padded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628162806.1067=
5-1-alhouseenyousef@gmail.com?part=3D1
