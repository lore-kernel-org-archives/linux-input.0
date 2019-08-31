From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 01/11] checkpatch: check for nested (un)?likely() calls
Date: Sat, 31 Aug 2019 19:26:41 +0200
Message-ID: <9de9fb8f-f13f-e9bb-c68d-0ba81010ae8b@web.de>
References: <20190829165025.15750-1-efremov@linux.com>
 <0d9345ed-f16a-de0b-6125-1f663765eb46@web.de>
 <689c8baf-2298-f086-3461-5cd1cdd191c6@linux.com>
 <493a7377-2de9-1d44-cd8f-c658793d15db@web.de>
 <c5e4479d-2fb3-b5a5-00c3-b06e5177d869@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5e4479d-2fb3-b5a5-00c3-b06e5177d869@linux.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Denis Efremov <efremov@linux.com>, Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anton Altaparmakov <anton@tuxera.com>, Andy Whitcroft <apw@canonical.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Boris Pismenny <borisp@mellanox.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Leon Romanovsky <leon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, linux-rdma@vger.kernel.org, linux-wimax@intel.com
List-Id: linux-input@vger.kernel.org

>>>>> +# nested likely/unlikely calls
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ($line =3D~ /\b(?:(?:=
un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
WARN("LIKELY_MISUSE",
=E2=80=A6
>> \b(?:un)?likely\s*
>
> This pair of brackets is required to match "unlikely"
> and it's optional in order to match "likely".

I agree also to this view if you refer to the shortened regular expression=
 here.
But I got an other development opinion for an extra pair of non-capturing =
parentheses
at the front (from the version which you suggested).

Regards,
Markus
