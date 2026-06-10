Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5549370AFB
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071975; cv=none; b=VmcSLR4IMgT24KKaLOH5Ptw58/Q7XcTx8g7kfNh7Ei2hqoBBQvv068LbaG/6SyA6rxcP+LXXpQDohtspKREiWnY35SmjS+sFfe1xBltpZEqWTcGHMV/d6w4ow7pxqcJWu6p15nx/8hPASKxeNY8tYwK15NdEs+NgbhEDgFEslDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071975; c=relaxed/simple;
	bh=op8rYcSBMGStuHhYl5iZoBPDpUZTYWHGV92Scc/aamU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5pmk6ortGTwvbzjy6uizhv6PfBXgjvERH91c8QC/sFIYUwNBUvFLP8y/SvJ5Sf+sSE8OZv1K9NaoexvOrOhkbpzDNiAbZhdPE+mombGXgv1aScvmNGw5dvb7uJjs4M8iVjgCNv26SBuQkT8Gq/9dkQrPL57/ully6HuGgO4suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjWKAU0H; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjWKAU0H"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307263ad0cbso8761120eec.0
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 23:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071973; x=1781676773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMudQFXHfT5uKQwYnXgxpWgI7x0i4hEvOydhOw3iJVk=;
        b=EjWKAU0H6KuJjmowVCbBb66bBqUX+u22GGnGboMKIun3Rqc9MRNWFH6GvD5ZVSUeUL
         3cuWvFrjVKN5JjGrfIgaL08Uj9oaMtWi5SXQGo+N+e4kkCmUrJq8CuDvGOGHbUtUxVR9
         4DoxP5S8Asp84jCnUMiSi0dCRXN0PQT0atZuLB805W4edmjRdGv4aVHXkYsi/7na8D29
         IGv3rsPFjRFnOOh7RigkCFATVa0GMash5ZxrLZP+YDVKPcPcUv5Jk1eHkPtw0ZlRC0y1
         0QH+kS23YSIueYY1d4Py60P/uX0U/ZlvguqBVM1aCvYjfPmBeK4F0WvZkF5E0NR6wb6d
         y+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071973; x=1781676773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMudQFXHfT5uKQwYnXgxpWgI7x0i4hEvOydhOw3iJVk=;
        b=odmgUW+W13Tgw5bEx9Nf9tQhgT4tbyWpbzOtashTnfylL8bLpcvpDG7QIMCQCe/Zzz
         4B3sSt2Lvewx/UGQGoKuyIBfOiHcqKz/RT8GQSHYr20jHi1Djh48LVcB9dtqNFgqGTnF
         sSsxvDk90oWElgrCkCmZIESzbXRm9yqfGG5VMo9zXTYmpcOO/hNYBWM15PEsbK4wUotP
         w5q0aFCFrJwyLdRO/Z16LCBNTWNmmfoJeRMS1C48ERdClXQrWWG5TaBKC2dD4bQX8FR8
         OzLtrBlRd+TL7gwRyIrf/W2sMHuUKOMfwohe/UQRYNeUBbKH25CVuwnHLGtD/X2cvuos
         qTFA==
X-Forwarded-Encrypted: i=1; AFNElJ8c/VpNZHyBdtiEghmLPrmCH15Hgqt4vG7214k1bEyfPmh5n0/0yl5cElr8YBlGqk5UahzbEt8FLNQs4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaR44CtpqOwoOjr3u+ymNSAidlUannco4Pktyq0Z9WypJtmmbm
	MUeNyQGNalEHYoIrPeMR1/tx+a2UjRjv2eWiLJFO2VqzHq9ywTrj83CH
X-Gm-Gg: Acq92OE1rVWxNjQGswQEJrujXdyzKD3mBZ7tdpXtS530mwg5aHS71M3OE2wIhkfB9s+
	7DeEK5WroSAD+8EMj2UyVCknqg4RwhbJJdEWHUYrPIAe2qM9mIk6HOyPQWQdlYIeq2/JH/Fz+4X
	hYw6aRaZGe9YLxhA0s9GS2IQZBf+QJthUvN3czgNoLhTve3ayJLkouz3agY64D7o80/jGshWK2A
	AUxxowEjoP7o3MrKSrBnmonzBZss+2YMLqY88xexzBWMTWc+9oNdq+f5DIuM6NaBpNvvX4L4BTc
	me3LboeMCY1tN3+XHAK1/QHvn3bM0azVlAYPZzwBBK5ebluel0iUJaeCfUGSvrLeWApsdMrrK4C
	jYe+CNRQVb0ULbdE0P8sTOQ0SaWr44qsnZG8iLSX1XPEvuRKKfIcFr4+mVuCsvCe6wcQf2OL7Wq
	5tLvfWB03OwjtqsAqy+FYq4CYJNXrKk+jLi63j96iKDMGdUQHL6hqn0wAS2MM2ACfzvOqRv5Pyx
	r1flOp2w85DIg==
X-Received: by 2002:a05:7301:5f14:b0:304:4f23:542d with SMTP id 5a478bee46e88-3077aef8be4mr15201999eec.11.1781071972947;
        Tue, 09 Jun 2026 23:12:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2bbf:a9b1:a73e:3f6f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm31762728eec.6.2026.06.09.23.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:12:52 -0700 (PDT)
Date: Tue, 9 Jun 2026 23:12:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Kees Cook <kees@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>, 
	Christoffer Sandberg <cs@tuxedo.de>, feng <alec.jiang@gmail.com>, gongqi <550230171hxy@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: Drop unused assignments from pnp_device_id
 arrays
Message-ID: <aij_gj5W1dylcbrX@google.com>
References: <f987c14dea1d3236d3889e5cf96c01eef6a2445d.1781016727.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f987c14dea1d3236d3889e5cf96c01eef6a2445d.1781016727.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

On Tue, Jun 09, 2026 at 04:53:25PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Explicitly assigning .driver_data in drivers that don't use this member
> is silly and a bit irritating. Drop these. Also simplify the list
> terminator entry to be just empty to match what most other device_id
> tables do.
> 
> There is no changed semantic, not even a change in the compiled result.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/input/gameport/ns558.c        | 46 +++++++++++-----------
>  drivers/input/serio/i8042-acpipnpio.h | 56 +++++++++++++--------------
>  2 files changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
> index fdece6ec1df3..f70a96c4f1fd 100644
> --- a/drivers/input/gameport/ns558.c
> +++ b/drivers/input/gameport/ns558.c
> @@ -148,29 +148,29 @@ static int ns558_isa_probe(int io)
>  #ifdef CONFIG_PNP
>  
>  static const struct pnp_device_id pnp_devids[] = {
> -	{ .id = "@P@0001", .driver_data = 0 }, /* ALS 100 */
> -	{ .id = "@P@0020", .driver_data = 0 }, /* ALS 200 */
> -	{ .id = "@P@1001", .driver_data = 0 }, /* ALS 100+ */
> -	{ .id = "@P@2001", .driver_data = 0 }, /* ALS 120 */
> -	{ .id = "ASB16fd", .driver_data = 0 }, /* AdLib NSC16 */
> -	{ .id = "AZT3001", .driver_data = 0 }, /* AZT1008 */
> -	{ .id = "CDC0001", .driver_data = 0 }, /* Opl3-SAx */
> -	{ .id = "CSC0001", .driver_data = 0 }, /* CS4232 */
> -	{ .id = "CSC000f", .driver_data = 0 }, /* CS4236 */
> -	{ .id = "CSC0101", .driver_data = 0 }, /* CS4327 */
> -	{ .id = "CTL7001", .driver_data = 0 }, /* SB16 */
> -	{ .id = "CTL7002", .driver_data = 0 }, /* AWE64 */
> -	{ .id = "CTL7005", .driver_data = 0 }, /* Vibra16 */
> -	{ .id = "ENS2020", .driver_data = 0 }, /* SoundscapeVIVO */
> -	{ .id = "ESS0001", .driver_data = 0 }, /* ES1869 */
> -	{ .id = "ESS0005", .driver_data = 0 }, /* ES1878 */
> -	{ .id = "ESS6880", .driver_data = 0 }, /* ES688 */
> -	{ .id = "IBM0012", .driver_data = 0 }, /* CS4232 */
> -	{ .id = "OPT0001", .driver_data = 0 }, /* OPTi Audio16 */
> -	{ .id = "YMH0006", .driver_data = 0 }, /* Opl3-SA */
> -	{ .id = "YMH0022", .driver_data = 0 }, /* Opl3-SAx */
> -	{ .id = "PNPb02f", .driver_data = 0 }, /* Generic */
> -	{ .id = "", },
> +	{ .id = "@P@0001" }, /* ALS 100 */
> +	{ .id = "@P@0020" }, /* ALS 200 */
> +	{ .id = "@P@1001" }, /* ALS 100+ */
> +	{ .id = "@P@2001" }, /* ALS 120 */
> +	{ .id = "ASB16fd" }, /* AdLib NSC16 */
> +	{ .id = "AZT3001" }, /* AZT1008 */
> +	{ .id = "CDC0001" }, /* Opl3-SAx */
> +	{ .id = "CSC0001" }, /* CS4232 */
> +	{ .id = "CSC000f" }, /* CS4236 */
> +	{ .id = "CSC0101" }, /* CS4327 */
> +	{ .id = "CTL7001" }, /* SB16 */
> +	{ .id = "CTL7002" }, /* AWE64 */
> +	{ .id = "CTL7005" }, /* Vibra16 */
> +	{ .id = "ENS2020" }, /* SoundscapeVIVO */
> +	{ .id = "ESS0001" }, /* ES1869 */
> +	{ .id = "ESS0005" }, /* ES1878 */
> +	{ .id = "ESS6880" }, /* ES688 */
> +	{ .id = "IBM0012" }, /* CS4232 */
> +	{ .id = "OPT0001" }, /* OPTi Audio16 */
> +	{ .id = "YMH0006" }, /* Opl3-SA */
> +	{ .id = "YMH0022" }, /* Opl3-SAx */
> +	{ .id = "PNPb02f" }, /* Generic */
> +	{ }

This goes BOOOM! You have to keep empty .id string as terminator.

Thanks.

-- 
Dmitry
