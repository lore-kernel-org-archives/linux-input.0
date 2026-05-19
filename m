Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779539EF22;
	Tue, 19 May 2026 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173518; cv=none; b=MXtOc1WK/fIVk2Hgmue6LEeZOrPqmF1UR0IIMV6G1f9Bnx/2IP5xj0cIn27BdLKc2xxVb7A35zmkT8OiXOdI+ZlJfiZr3pGEGNQzsXoFjXvCSgep+o0UBpPjV2IwPF2/KZJCfZPu5JuH5FtYCChBEJahkD/0N0CHfLruClx6r2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173518; c=relaxed/simple;
	bh=0imHbSKpa0Or7EwUowbgnPxhhIXEXiHdPFiipgJwXP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3bx3GyvC09pOn1SJ7uJlOs8IhYGKBcns5s2GGMtJxKq7/VnaksBD1gsi5yHsRMI87q6R+Q2ZV8xoXJjOc2SDZfCPrf4fANLUXBy208ALHUnpHCyk7sEp4J8OLVB6soTCOTEQp2d22cs7Ew01ett2eBopMfPC6bSIJE+/VHxnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=h6repjP/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="h6repjP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779173509; x=1779778309; i=deller@gmx.de;
	bh=UK/ItpVEyTSBBzGxF5aYqKYWP3SqQYef/6I0a5bxCDg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h6repjP/rLsu6Dqk+ru9RJC9znIRVkzfvti2ITw3JIh/ReYUznRI6nczeYMmO/hZ
	 VGgNKZUZSTQvk6O5CQZzQqeM6sOlb6hNmtuKoKwQ5ZAjnWVq3kLpSKj6wnypzE+pM
	 DFJOVrIjU+I3Ef/fUMGmvGK/uibmMqNTL+6DpJjlcevyBTV1FjdTG7pXGB5ZnIpWl
	 zRgsucsADUDiGZctMy75LjcADJTWg5A5Lp4GORPBk2a8my6h8c69JvrOHh3pJeYdk
	 pHRJEPY+myaaLWkA5NtztgVmnYocfgQmaL2MW5JNTNbhumya0KAjB3rF8ZvcFB0R7
	 ORbc6Bs/jg+wI4/10Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1whApQ32x7-00OSyc; Tue, 19
 May 2026 08:51:49 +0200
Message-ID: <0f262564-5c7a-48da-a5ee-546f7271d81d@gmx.de>
Date: Tue, 19 May 2026 08:51:48 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: move Risc PC-specific <asm/hardware/iomd.h> header
 into mach-rpc
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andi Shyti <andi.shyti@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>
References: <20260510031100.255248-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260510031100.255248-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WxHE0vKpnwnI1xiX99q0fmbRiLsc4cVC7n55CZvifq0B3rE3wl2
 l48T6yYOH+t/M3t2pf8+DmCdG/BmY6TnonGGkqnFttvl1RTfEJ9o+oRVogHoIkGqQPy69Ye
 RJV/6N13C9j3Hk3uJIlhh4Qzk3UXqHx/9ZBMD4KB0tVSXylnDq1Ay90qubCvLwaKLqf5sAV
 OfHB6etGzO2vR9DrnuJ8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0SBpDGxz0YA=;BztV0POZQ0bTyCa017p1CeOc7d2
 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
 m6mgxQ==

On 5/10/26 05:10, Ethan Nelson-Moore wrote:
> The <asm/hardware/iomd.h> header is specific to the IOMD chip used on
> the Risc PC. Move it into mach-rpc to avoid polluting asm/hardware/
> with machine-specific headers.
>=20
> Also take the opportunity to remove a comment with the file path from
> the header, which is bad style.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   MAINTAINERS                                                     | 1 -
>   arch/arm/mach-rpc/dma.c                                         | 2 +-
>   arch/arm/{include/asm/hardware =3D> mach-rpc/include/mach}/iomd.h | 2 =
=2D-
>   arch/arm/mach-rpc/irq.c                                         | 2 +-
>   arch/arm/mach-rpc/riscpc.c                                      | 2 +-
>   arch/arm/mach-rpc/time.c                                        | 2 +-
>   drivers/i2c/busses/i2c-acorn.c                                  | 2 +-
>   drivers/input/mouse/rpcmouse.c                                  | 2 +-
>   drivers/input/serio/rpckbd.c                                    | 2 +-

>   drivers/video/fbdev/acornfb.h                                   | 2 +-

Regarding the fbdev change:
Acked-by: Helge Deller <deller@gmx.de>

I assume this patch is pushed via the arm tree?

Helge
