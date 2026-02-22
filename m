Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72099191484;
	Sun, 22 Feb 2026 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757302; cv=none; b=enEYzzrhMq9tN5Yy0+xoXHxBNkG1ZDc6Y0rl0pNH9lykJ8lnnhqnz9/h6h1TetnO/MEIC/LsEp15AlDtllDv/wfjpSsZoD23KXOOMIy7rvNq06nbhKWRla2PLhnz0MQ6G33Yw2bsVdSYAp/m+hcIpWjIuiY7cgB6V8FzAeeG0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757302; c=relaxed/simple;
	bh=5n53ObjcfCUHdjhpfJI+sk5BAI3jqvPZBCHtQMtNdn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fta9nyAOMCg0JAX29n5Kra9HvXltrkyI+dKTVGidLq9wAIErKzPIMxr2Iu10yvRArRDCIor5zXQN124dpvnJzMJez+d3ICoFNOS5nd8z9hb7IPyiAyZewe20+Jsi5vFznpC4w3Sj638EYlt+b3YkqiDuLM1q8btxYmzh/vBZKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRVS8HvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRVS8HvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4EDC116D0;
	Sun, 22 Feb 2026 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757302;
	bh=5n53ObjcfCUHdjhpfJI+sk5BAI3jqvPZBCHtQMtNdn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRVS8HvRftdYNqYtPIUJgKsyeHWpAakc3oYMSYn1p9zNILi5KMnThHFK77ekpH8Ci
	 0RKKnT5fWdO+NUFeFkUJOgfnx1T6q1NA1CGCOycWg2qMXPUpfqMxVKCukn2tsFjQ0A
	 ZICWb+4kg9VXT+sb0YJecNB4aMBa7f1e2Olgp+7AQZMj32FJi3OURgSYN72gjoX7ZL
	 7DFTkTrJwGJkHhY7NUf+6LTNanLiyy0OYskKS2R4F1o+k0PNACT4K6ZGlb8kXbThau
	 EH5gPjv31vTlAZAApBKvgmFAbEJCyT+s43BKhBXiLP3NoitpzSeVMhBRbihMgi9OWb
	 Jk5d9QbUNBpow==
Date: Sun, 22 Feb 2026 18:48:18 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Input: cros_ec_keyb - factor out column processing
Message-ID: <aZre8rWDvVDZ_T6p@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-7-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-7-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:15PM -0800, Dmitry Torokhov wrote:
> +static void cros_ec_keyy_process_col(struct cros_ec_keyb *ckdev, int col,
> +				     u8 col_state, u8 changed)

What does the second 'y' of keyy stand for?

> +{
> +	for (int row = 0; row < ckdev->rows; row++) {
> +		if (changed & BIT(row)) {

Maybe

    if ((changed & BIT(row)) == 0)
        continue;
or
    if (~changed & BIT(row))
        continue;
or
    if (!test_bit(row, &changed))
        continue;

to save an indent level.
