Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BB36DA04;
	Mon,  1 Jun 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325296; cv=none; b=pMox5uu0VUz3SgGkO/OSyFsUG2NP1WPZFUKvqNqx/NFpIcWRkX0S1I1oXV2vYKXGJDQlWQNmh/zXyuM6U7zd23eaESSSAiVHbrzrajBg9gNPTuCGe7bCKFwuTWhc5iMFgFWzhICx2eMCxj9v7WQhC2MFgZM0cWOIrGD+Sfyh72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325296; c=relaxed/simple;
	bh=fJ3xH5xlTRoAEiHhIhArACx+c4iGnMQactBUAU5W1jI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=POjl0qq4ItCP3GyNQNJEY0KxMZ0VPkUZGJnnvcHKNDlDRpNyR2MYj61IFrJXWumrzXzMD0S98vY4cN+PiHQlhms4IMO0cnbRWcVXqG0KEWgYAS6DVpzBIb9ZVjL225C7xCTbALp5eVJKdn2cF6v4Kkn5TLsoEWTRKP0KXLPXh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gLP8BXfo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gLP8BXfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780325293; x=1780930093; i=markus.elfring@web.de;
	bh=HU8+n4kt2sNc/fa6L3fhGzQ1SwFUwTwvIXwDbFfUm9U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gLP8BXfoR8s69qLZ96plM0WyvFN7PMMwV3esGuUL3qnmeOMNES58HQao020M5ATe
	 dBEWcr1jnvJvwr7inoDgQIqv+NSwunDT76C6ji2AuLY1Ova84du/6N+X1iOWDnCG7
	 2Ea2aPuio5b10OLZfk5xaFZ28bDcX1JUVMymGc7JFQsgX9RZy10nd9TZwBIXN2Sc7
	 7/0jjGjUOBDYe+zAeHYhl0Lx955IRdpIVX985Bfbq25p5CaP3PZ1B4kAVD2uNr16H
	 AcFGWejGgO0orTeofVlfwz4sboM70OScSnDa79hoWfj5a3EWljHDbHs5u4Y1zUsZw
	 mybC7fwMJ8oCjnAybg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n4G-1xOevS3i1W-013GYJ; Mon, 01
 Jun 2026 16:48:12 +0200
Message-ID: <94726c18-71d0-4cae-89e7-eeece38283da@web.de>
Date: Mon, 1 Jun 2026 16:48:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>,
 Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <ping.cheng@wacom.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260601140845.1237227-1-lee@kernel.org>
Subject: Re: [PATCH v2 1/2] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260601140845.1237227-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J9PSdngm9XMety2SEsI4oF6K56TcrceicdXDU8HUTrT/nleutXU
 8IJHjdhZ+H4AC2tlngUsjRpy427DsQ52n0ni3po5iCJRWZbHXNFV6uCDFzd78Qm+uT1+Cuk
 89UZY2HA+riw2uUXZXFopzzkmpwVAUhGqtncE1D03+NNU0Q8YynrpJH12gpmeAQ+tDjBCiv
 pg+0pW/M/XVbSTo4Jc1qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6+i+oJtkkE=;WhxV3pypkwcYZCJGTQKu3qfCFtZ
 0m70zjQc0KvjSsyb4XGHLL2zBYZ9b5gV7phe5wePgcQ+QHvsTUhejpj3l+a9kZh7fH0wBeG6a
 5y2DbDD7sv0uzXW0yY+YDxVEi0cBJO7w3L9FBJRZxV9Hil+fF22Jg+AtJiGFqcE6IzxfjfMr4
 n2jt/tpkynz8Z5/0bX9IqafduetDmYMiKJrxQ4EFBlg9aQ5sn6M5V6wvFudZzr/q5DwsdbvXQ
 g43ujeWVLE2kPPHWG8HIbf/ElySl2zUSRiVO1Ihj26PxBLTQqnatALKPyqtkg9IrcLa7Qlikg
 ry8GgOmRKqfOMa8rChXPK7ItSfJwJtPrtLAozCao8fRxDw+3r4llbEbKgAKTFVpoCQhNVTF2e
 6kRbXuCUIt0b6T0UQoAPSriG7YMa/GW7+TEVSBkjrnf7/e6j3EtK3Iii4TOLL7JOHMhByOSCP
 wyVcpNd9dlA0mD5K7ITVAg7bQ77lyl+zuUgJMYRGCONFlrgWgDUtxNFcAbvhnM3BL4Z6kEYv4
 qj1YtVaLe+69zSUrWZX7RcIK67094eHntswmET+nyrDVVbA9dy6rFJ1ZodHyrUNsZvvjmCcIo
 t032ZqNC8hwOgAyzfn65Gc2ZRZvgpzxNNvWjTI1nf0dPEPsV7Ep/VwrWs6Fb+IArlp9d1Fbcs
 LU+Ifr0D9kol/uH9gos4ry+KYqqK81WaiCjjV+mcuBAv5S11FXmNPbmic9Tqqz+QufNa8ulcg
 4eVLGLsXbMgA/kYzUPoNyPWJ4Esfl1k6Qjeo7x8x8S22yt/EN0SJwcjdaN0Fj1aPmaAJxCk4i
 CppvCdQJ5XhkZDtFlfkxS1g0A4L47Cq0B23kLr1Nr5rGZqpMCAbIEPvGSvdwyNUVdqdtDfPQK
 zHQMKJOa9bhSiVz6y4hByXEDsyrfl5vVvJ01Fyy4F2nYCgAtH/n+qJoeSbDkmSM8RtoJDFQvX
 cJbZMKP3jDGsz4cQSVci166Lhc+xQ6Qd91RE8Kz5XuRMCzlJKjJvGW4B0Ngru3TADZBU7ApJp
 6lONpKG6B7HU7XS1+6/hNCELPBbC2xvI3tHl9GIKr57mle+RLnRoTvR+wbiOvwYYB7yTO7E9m
 rwxv8dygHYR1fTq6UR/aymMSOQWZ7LkTf/JwrycHEUvvyFgdEce9nycu4fzcSmX1TmbsWEPGi
 E87w3duQbry4SHTI9SPZgHHe1GAzYFrOsDqBGEcPDP1PeOiEeRdZGK4fbwr1901N6A4+fOSCg
 hG/R4GJzDNCsR6cfVOny2vqngSeXW31DwMWtETfHJqM72+p7XOMDhy4NYKd16gyjQ58huVR+q
 vHh2mpn/FrEjZH42Of+XrfYnywpOadgJhPv66smkolVw7ScrzvA/ACIGPm6xzPzUiIa26g6eJ
 Q6sSzG0dW3fb8Dvu84kmPdHQqajxdFFOwHSNmfdy0KWsJsCqR4IxVe5tKMyBvPLNT6iLf2SdI
 5h04jvUwtGMovO+f4n2v3ypmTAWfkcW0mg9IM598cwt3FOXKrAe5OQE8nzalNp9DlOKSPamdg
 d1KkkU4WzHnd4N5WYESWuxHWPhlT6TxhHOk4OfWuOaIiTUPv0+8lxkx1L+2Nsqh3Q4ZViz2hJ
 JsG5t5rjrZeRnPgv55Uglo47abxQrDuBpwKnOYudhlSd62dkJNcJBMzlDhjPYykZnECZ4cuus
 9qC+/u4z3lWggpH1jEvCIXSYNk9h8pWlX0L/JzA99BxbvomIrjxK+M1I80+LDZkLqEY9HeSvZ
 oznyilMgIiryWpp7cwNrYjmCajHClwwE/oJhBYLTbw5RpFo2568FR7vb1gqtpqZc6Hd6rXdOQ
 onqpuP2KbpcMAfAzWmd4nBc9sqxHhmxiuYXBxQmdXdFJIkfRFZF6BRMY/utsZQ8MBxnQpJqQc
 xPzm1PeHylIBdVth5B0BH+aXwHT8zSWCeLPV1CjQDSUO00R6WR43ULJslW+esvNJccnEORdZe
 0n92kX20ELF7ynIpCfPPSRn0h2aIcX4p2SNlGzk+C50auLIvKgzmNFxey+o5A9/wMG5W87wyl
 k9xpG5k/OzN0abQggBOmtDIrP3sW4zhNGApLKDtFNNgqL43XCga33DO6Q8VSphNt9+EPJZIXT
 jNizwNzQvJ7ODyTLif+g+7AnreNIP0ER6Yx4dfa7gZ2PTndP+l9FlIzUNqfBBr2W0oqPhAETd
 4FmWBHfkDmUBH2KC0JB0M1yiK6dMMu6a6ZTp5KatRg9QQEqI09YCdkJLlUlaHssTk5/pLLVxg
 cp/OQaBMeuK2qg+2yPsxQwU3vQW/FmbXBPmNDiccc3v/h9Iizn74aE6DWgVITv/OuVS7D2/BL
 ZR4n03vx+q+xnkZBdEd+dpolSJXne63lfLyi0u8GEmwE+IrIR4+lTr5eofsaJYzw63d/rAcEu
 khMEOctkk8pWvhw2mC6nhmH3EejXRQJr/v1sj7un21mhwntbI8igciQWftvPL2p8tXRoACIaV
 XOZPqfrA3poRydxnYU/8L2hTA2fwbLzbBJAFcRH9IZSbUOHXuw/uU0tDNYlRiP2RV8b4nDcUE
 E/9mZg6PC9S5rNjbnGfU4v+lOV3HM6ngh1jd98RMXp8tu+dVsbfyFcHjarvdFCjRmum8DzGJn
 Go6MOLYKbCDnorAQuKEUAXLkzlrWlCh8nF/ADt+SRYS6l9clcJ6zsQ71jfk6bJWw2fz6CamUP
 AxaWWNsSWUKeJLBdsKDCBf8xNLTy8lOTTYkxrizU7l3Z0sxJy8sWoO7QmH7ByZOz84cOvwu9s
 lDu8T1YNkBynx7OiK9aaLl/pHfY10b2pEnBNCbkZvYb07/j038zuF021W2h0/rI5DunuaD8GW
 ICqSagRpvf5tEAzrrzEYeEmUgbb78TRF/568DI2srq9n/hxNSruAbysQbOba0zjfk8Mq50SJw
 kpfuCz+Cn/w8EmLlIWaIZtuP+8uc5YSMiphBzZn7Am7GmNH/EMvT5/1vsb3XxRTY+7vkIE8Et
 MIqjB4pWKgVPSW9JQZ8pdUTFbTXEwHz6ryumJvsI+eT279ANkOBMCD9SAHtIFSs0vGfwNxCZW
 xuU3tgy75EdC12VLq8JlsoYmGVVe6KFs67de+agQt4ELKUeRDhyDONp0rAwR3OwAWUe3df7+x
 kYi3c8Vy3GeAJSzhaOrVTuji4r2oxNB+cxxvbT9ASvbD0WTqbq6n2uZEPB/MUQVhImyvI582P
 uz4pzQVmUGPXN0UWzpNwb8t8B00J2YYc5EnkBeMoIRlyU+nAZlDwyKa7Mln33HGkITEYBrf4U
 3JVOQCNhoCkPCfYDR+EooPDydjhKRJoIBLrU2anVm3G5+o8Dlxs0KYABwjS21uwcZZ3sot39z
 znSsbaUhzSMikl/4nTMUZAdSCEJ5DHEk+zGmchn0p9GH2k4DPu8NAJ0e38Vt4Qj1BC7S96NMd
 HxmOQ0F4RlSp30Lw1N19jTBp5DUpKNCAbbm5BHvTQOwt3NA8O/VTJ+5J1MKN/YuQ36EubntEq
 nNNZfZQUW3ExX1i2mPtNc9ohijY+Nwr21Fr3WamDTEtZCzjGSFapyZUGN4u0tpQRD8yd1Fzk1
 K8FKphosoYQdQazirW7PLY6KYywgsow2i91z/T2+kaLRQT9+lLwAoFgnateuVp9sqdXC9hixq
 TYnlRosuDMoFr9n8ipkByvdGdk2sslhPCyAwQ43ZGDlHCI3MFn73LpIZOL+sGmrXXEA+ZiyGt
 +RWO9J3ORqMy0+eOXrWNv04KhdtY0HYTbuYlgvzEWzY0n5cHaYRFzZeZuKeGzGbCU9ohsJn2p
 nN6EkXsbYa7uiDzwj9JaxzDYvfMI00UgeAkF/B2YNYiHhYCjLif/r9fWK+19QG16JgW5cm/at
 ktVsuTKDyMaHb91eu4aSkyZul7uXWC9GXzcFJYUrXuk45SdBBexXqe+fq8P+HSnQElbo/TSt7
 x1xNw+qz3DCaqt7wqi+Cru+qtJTWCM4Fkxsk87IEpms5BusschxClHVsERXOgi9vI14AGC1jV
 YmxLMQEZToemF11x2K0WEd0xwhCl/VwN9KTRaoKaVZGRTYUdw2RzHolTqpc0l6D065P3MBQUc
 5KCDSPHMqUYZSAQoNQLvYSSOeGTmYfE6yIy1bz2kOsst6KQVNuqOti1fO1vosKZ0DLRfzU7xQ
 CACdkHfIeM2Uf/tAlk3X8Z5lGr/iESTIOSOBo6xs0VkTPdU/ndR0JMnkh9xR5P8c5mfnqlTjz
 6YMOM50pMpol4taLg9nC7lzfB84y+IuDiX5bdJKcbJDhISB2V8d5fFpyW/lXcwdSmOVKCdsaR
 h0VNPEks692BX5/hd1sgDFTMzSeuIloCCYcveLLoIWbMF9943zULLu8mqMdebG4kikL0NZjAN
 8BMcILmHlIocGKdI8Kl8zn3Q6KAMjT2ssHmcLHKigVxfxZYkq6i4JMACqTBbaxoRMJ0Elg1ec
 nSa/xxPal0nuggnQXBSfygF67u2xeYUJApH1YJvmYhT9xkHaxkbd3Qvy7qDJISghPs+m/jnSL
 gFzWVJonLuG/3TxpazeWUqPblDCYBMzdN52KWMr3n0VTQkygCPK+Gs3/9EeKllqcU7K9u+boN
 RZ4jnqS7jnGm86Tj5GkndECE5tYg72hyYt498AIGuaQZ2DMEXQRBNwveO6Gbx5Ob9wR4WKFIt
 y1R7TOgjO6ZhB//gb2PuAW5+E/IXWtRs66RHYJrVkW5F8bc0aT3CG170O8fRY8hMQ0ei+2nXi
 B9TIEpO+l32WDfM+fjuW7HVBDNrYmxggLcH0YpTXArFoE1WVVe0JdDIMB7HmvwQ6Cxr1n/ZA+
 Ah/y79RaDKO2YqRZ/x29CADSMfzqKZmVrgMo6ObT+QMY24LG8kZJ6a6nTqZC3gIXAXtEAynlt
 NZR6Df5pzaCNL36K1cSYwANzrxHbxr+plrFICA2zDiO6nedLaODEmOkSvdALlHSqIctcjKgnx
 qIaj/SEZILy18/n09m5CXzEZMHLaobOTrzLmXOtzBfKCO1HcMB0NU4lIgIc7D5Yx+Zu1cx7Hl
 +FYErC7/swdlMPZ9jzo273SUF2gGsLzt6dW+C5zm09VexLfXpoKcrvGqETwiqTzdz65t8auZ+
 97+HH+VGYd/FjzmqkeBhVa158HyH/t6QNGXfc9Fj8sBz+pDjDjq5pPjR5BjHpT9ObGYejjMfr
 uxM5iKYnDVzuaozl9n8hdmqxEXjYPTlDks/3Ov0CHjTxQbf15EuUHMI3ml7Oh0V5UpcxzsLly
 XkFKeBQb9+2CsrvEmVanZIOuFs4Pmjun+ABT6ExtZYCswor+SmPG99N0Zp6gffEkio4Lw9lFm
 TP0mJPp8WvEPCOkZxwapGS5uPxIwjofoM48NJyMQnwZ2gLP0coYZOhhIAS4PAGETU1ZGME07s
 42grzB+ZZG9jYusxfD0AWz/TqxsdZtyIEKPqvVlePUIrqItaCRt0SDkXCkvpQCqOzyyDpFla6
 0gzJLZZdiZymLm1cPx7J5wwZD3IMbmFmzGgYxJJcqE3akueOOW+qSaXS9WNqiRMxpDpACtfkI
 VuVrfRadAmRKK0eFLpdozHmMYvh+vBkfQpaECPHZb0BC/XNI7OTkp718BUsokSRZIOgGj/NgM
 bC8z/ZabGy8GKx602DOJ4WpKWVoTQ/e/+jLrMErGQpvcU5LdyLRfedh11PdDtYZde13MwA==

=E2=80=A6
> +++ b/drivers/hid/wacom_sys.c
> @@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> +		mutex_lock(&wacom_udev_list_lock);
> +		if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
>  			wacom_wac->shared->touch =3D NULL;
=E2=80=A6
> +		}
> +		mutex_unlock(&wacom_udev_list_lock);
> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);
=E2=80=A6

Under which circumstances would you dare to apply another lock guard?
https://elixir.bootlin.com/linux/v7.1-rc5/source/include/linux/mutex.h#L25=
3

Regards,
Markus
