Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDA244667;
	Sun, 12 Apr 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003653; cv=none; b=Sg4p/7qx4DP/1KUp5PBM8+wCVn40y8tscMK8L4cx4bP2gS0QnT0a//IdljQMfgDXdHnxac5hwVxe3UQz8SBaciS0sBM4oQ2WfaeWsoPNixUcx0Gyxl9gvMDLP/nt7q35Tq2Q//zrxnm2xLVa4vKL3nn1QPd3qBPxT6P54ctgBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003653; c=relaxed/simple;
	bh=21MciLSfsIm+vx0QwmR8JoyATXzVAFy1g7AsdawmLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8AvvoZnDaJ8hrboabrbmpovKPxNjYQ6trPLB59/zQVGGWFnFYaIfJNXt96sg2F20/MnxPw/32Qz3pFgKwGygI6i6ddlYOZfg8ryEQFis4vhqb7O+z27jSKj51T9q6zEOfDLJkY286cpsOSGV6ukjrIuL+xJegrdudH3VJ/UvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewFtHKby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewFtHKby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35193C19424;
	Sun, 12 Apr 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776003652;
	bh=21MciLSfsIm+vx0QwmR8JoyATXzVAFy1g7AsdawmLnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewFtHKbyz81jFrSjxfK+5ZjY/+qlkMAc8APethdGTLDhcmXgo48aRoA6indKg8DaX
	 Zllvt1DLsIDSrz4fBOP4ehnHpI1prtiY7Npe5B8PUkrwyzGaeyYFkbFcloa+170+IO
	 Ru2HVZkhU4TOsC3yYkv3Uf5XNRTuVUXKHTtFJW808cRctgH5TAYaAnGfArS0gSQ4A5
	 OxjpHvFj74LyL9JRKC3U3gAaCA/ghoswiK39pvn6NnP1/unuatKN1N+X029IukRRmm
	 TBv42JuRIyjdNUqa28bkgba5rZW4IYQaCsUA8by30DrPNYwtL4u52LqVQFMWiCNF2U
	 UoiR7MD/L2tPw==
Date: Sun, 12 Apr 2026 15:20:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?=	 <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Lixu Zhang  <lixu.zhang@intel.com>,
 Francesco Lavra <flavra@baylibre.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iio: buffer: fix timestamp alignment (in rare
 case)
Message-ID: <20260412152042.547399b3@jic23-huawei>
In-Reply-To: <00213b587ae4f9bde11ec928081abb60ddbed09a.camel@gmail.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
	<00213b587ae4f9bde11ec928081abb60ddbed09a.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Mar 2026 14:15:41 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2026-03-07 at 19:44 -0600, David Lechner wrote:
> > In [1], it was pointed out that the iio_push_to_buffers_with_timestamp()
> > function is not putting the timestamp at the correct offset in the scan
> > buffer in rare cases where the largest scan element size is larger than
> > sizeof(int64_t).
> >=20
> > [1]: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-hu=
awei/
> >=20
> > This only affected one driver, namely hid-sensor-rotation since it is
> > the only driver that meets the condition. To fix things up, first we
> > fix the hid-sensor-rotation driver in a way that preserves compatibility
> > with the broken timestamp alignment. Then we are free to fix the core
> > IIO code without affecting any users.
> >=20
> > The first patch depends on [2] which is now in iio/fixes-togreg. It
> > should be OK to apply the first patch there and let the rest of the
> > patches go through iio/togreg (the later patches are just preventing
> > future bugs).
> >=20
> > [2]:
> > https://lore.kernel.org/linux-iio/20260228-iio-fix-repeat-alignment-v2-=
0-d58bfaa2920d@baylibre.com/
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied 2-5 to the testing branch of iio.git.
Next cycle material so won't be in next until I can rebase on rc1.

Thanks,

Jonathan

>=20
> > Changes in v2:
> > - Don't say "HACK" in comments.
> > - Cache timestamp offset instead of largest scan element size.
> > - New patch to ensure size/alignment is always power of 2 bytes.
> > - Link to v1:
> > https://lore.kernel.org/r/20260301-iio-fix-timestamp-alignment-v1-0-1a5=
4980bfb90@baylibre.com
> >=20
> > ---
> > David Lechner (5):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: orientation: hid-sensor-rotation: a=
dd timestamp hack to not break userspace
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: check return value of iio_c=
ompute_scan_bytes()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: cache timestamp offset in s=
can buffer
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: ensure repeat alignment is =
a power of two
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: fix timestamp alignment whe=
n quaternion in scan
> >=20
> > =C2=A0drivers/iio/industrialio-buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 46 ++++++++++++++++++++-------
> > =C2=A0drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++++--
> > =C2=A0include/linux/iio/buffer.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 12 +++++--
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> > =C2=A04 files changed, 66 insertions(+), 17 deletions(-)
> > ---
> > base-commit: 6f25a6105c41a7d6b12986dbe80ded396a5667f8
> > change-id: 20260228-iio-fix-timestamp-alignment-89ade1af458b
> > prerequisite-message-id: <20260228-iio-fix-repeat-alignment-v2-0-d58bfa=
a2920d@baylibre.com>
> > prerequisite-patch-id: e155a526d57c5759a2fcfbfca7f544cb419addfd
> > prerequisite-patch-id: 6c69eaad0dd2ae69bd2745e7d387f739fc1a9ba0
> >=20
> > Best regards,
> > --=C2=A0=20
> > David Lechner <dlechner@baylibre.com> =20
>=20

