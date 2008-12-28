From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: hid-dummy in 2.6.28_rc8
Date: Sun, 28 Dec 2008 02:29:14 +0200
Message-ID: <4956C85A.7050501@pardus.org.tr>
References: <495293BC.9000104@pardus.org.tr> <4956AF21.9070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755022AbYL1Aat@vger.kernel.org>
In-Reply-To: <4956AF21.9070807@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jiri Slaby wrote:
>
> Hi, the error is non-fatal in this case, in addition, it's intentiona=
l. The
> module is there only for dependency loading and kills itself by retur=
ning the
> error from load function to not eat resources any further after it do=
es its job.
> The module will be removed completely in next few releases.
>
>  =20
Hi,

In fact, this was probably caused by CONFIG_HID_COMPAT=3Dy which was=20
loading all the hid_* modules(20~ or so) into the kernel. I disabled it=
=20
and now the message has gone.

Thanks,

--=20

Ozan =C3=87a=C4=9Flayan
<ozan_at_pardus.org.tr>
