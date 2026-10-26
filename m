Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793014356;
	b=T+Pf+xd9HSP/3wNLvHClIfhQXVj2FtlcirIHKsHImglYTuHG22fzoY7nxhSvMe1jN7qH
	 L265/22wiUZZOC0iUXyLn2U0cNnRYYpBAVYM+xJBdiHtyElgpl08pDunlH3OztEdeTxuh
	 PHMJGYrWfziNZGALSQGgy6HZMMKWCg/4OH2+lQlUUD0lP4wEFvsl+aK6Y9ufw0D1s+JMQ
	 PNG1X/Ym6iyknJwcdwG7h/QKjtbHxQph3XWizWeFw42xpLUNiJkASC5TO0JamXFQODuE9
	 TLeVDz1VWAgs1e9urON3VBWDDItq+Vt5xvqLocK14UGDsPWCSt/Ui9Xya4Uo10FlX6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014356;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=350WyjlEhFOBWBzsN8sEeJGdamHz5Y5z+G3u3uJ+BRs=;
	b=Fqjxgo1XwiNqza/Ngyg3lPmnLAL2CLS9d7gCDP8bIBc5SizZd60cdk2qVTuTxOjH0cfZ
	 51tsasB9BwSBX5GoH9L6m5Eb5xqZsg++rNJx9XRdouaoobI1xgjuxFnzft8V/DloDlMnb
	 etlkPWUO1oF/2xMUu+XCS9Jhdhtk+oUK8Lxd64/SAIcIA/ESAWUSMT6p50TRAEZycxeoY
	 YdBUZSxq5OOEi2Ir395J4YuE+URdNwW5uj9KNjtnoXuimU5Qvjov8r/jiMn7AvH1B9PbZ
	 kJuZN9Y0hXsnVNk/sY5u381jyZXlZAAtWmr3541aZ+6AazxrgMhSixWiLvPfpSrpPgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=Zmu7ISlT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F0606A31B;
	Mon, 26 Oct 2026 11:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 699F0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=Zmu7ISlT
Received: from hillosipuli.retiisi.eu (n18ws8cotq5gnfn8-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:0:19f:4ce7:0:938c:d2f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jCs1D1TJBz49PyT;
	Mon, 26 Oct 2026 13:32:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1793014352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=350WyjlEhFOBWBzsN8sEeJGdamHz5Y5z+G3u3uJ+BRs=;
	b=Zmu7ISlTLewJdFu1YoAQCrR1+66GT0sOAcqEGogQBVg5+v7luYlPMCuW2wy2S7zalLnZzC
	4/IHpWCPqgGeg/99XOR4Df0P38O2C6usqPAgsnvTOSuw8KJx86AFjTELVXspPajvXQCAPd
	/Cc0OKHpb2BZNYQXEiMMQPiec5haUkEFkF6c7ejUHM7+MnVbyuTfhoMDjxRayyqlvhQEcl
	ljrSb4laEPVFT/E1GqPHhxGNsl5zmBED3B1GHW5WjVJXelcyHlE7trFaqmBGeb2AbqA9UE
	nrjab5Hc6qUIvyVot9CrPAFEML7EHX/EfkRCEdv/C/891i0ry0T3vze0c8DWig==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1793014352;
	b=tLtD9N/yj58qaTiHA3P27tnlEAK4kkkRoLc6sP5w0y/XWOYxul7CW98otA6TjhZLvVmFRV
	4RJVEdEbbC7w15OJE8zghTI6oFjskOKACpnQoMQP997B1ESKk3WGqzTuX4Du8uZWzjMK0o
	SAPdKnfLbNdwIPey+IA/hR3fFD/d+mjV5VHU98SzJ6XWzVZlB/LKR43CjAH7/TMfK3aGqn
	zM07GceffMEUyYOMEPoDLcxAlLfSZ+ubj1MVcRPLu0MqpxaEFhp85LuvsRORxR3W4l1jZ3
	41EtI1eD9z6a2r1cg55MwJCv0WdXcViQc0RmqhMxOnTbXQg62LNOhx57O+0BUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1793014352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=350WyjlEhFOBWBzsN8sEeJGdamHz5Y5z+G3u3uJ+BRs=;
	b=hV29ep55jN0Fb3Y6IU+YopOouTw+G5KwX7hcvmCHuuKb10DXUt6UQkr0BaJZkx2+gGutdC
	Uia5Pbs2xRz4igyefj5x/Uz7CTjXkp0ZQhPn3QKqCkOw34FksBgYzoqPSR+0PzQE5GZOcG
	tGvvVodyc8wV6+4yAiCN7XSNfF/z/0YfFX9hZaGExvltI0pPyUcwLTOWygMceyzQvIv349
	j9DiTXvsgOm7UufuDTCAWZv4YZLucsSXoOnon1YBB4xHWHnjZsyaM3yCf8iZQDHdPLIG1A
	GkV3QOl69ze0UXoFNCZNv74AekgZBHVBWYY3CPg8WsWSyYeccnOAB1QuXpUpJw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3F70E634C50;
	Mon, 26 Oct 2026 13:32:31 +0200 (EET)
Date: Mon, 26 Oct 2026 13:32:31 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schyboll <dragonn@op.pl>,
	Denis Benato <benato.denis96@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] hid: asus: always fully initialize devices
Message-ID: <at86T3plbYCnXRAl@valkosipuli.retiisi.eu>
References: <20260216175539.12415-1-denis.benato@linux.dev>
 <20260216175539.12415-2-denis.benato@linux.dev>
 <at8jnW4RaMPJItUK@valkosipuli.retiisi.eu>
 <6b5fd961-245f-4b19-9007-03af59170ca3@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b5fd961-245f-4b19-9007-03af59170ca3@linux.dev>

Hi Denis,

Thanks for your reply.

On Mon, Oct 26, 2026 at 11:00:52AM +0100, Denis Benato wrote:
> 26 ott 2026 10:55:55 Sakari Ailus <sakari.ailus@iki.fi>:
> 
> > Hi Benato,
> >
> > On Mon, Feb 16, 2026 at 06:55:39PM +0100, Denis Benato wrote:
> >> ASUS has more devices other than laptop keyboards which needs
> >> to be initializated: the init sequence is the same as keyboards.
> >>
> >> ID1 and ID2 are USB report IDs that are correctly enumerated:
> >> send init commands to all devices that supports those reports IDs.
> >>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >
> > This patch appears to break input devices on Asus T100TA. With the patch
> > applied, I'm getting a steady flow of:
> >
> > [  256.358075] usb 1-3: USB disconnect, device number 120
> > [  257.034324] usb 1-3: new full-speed USB device number 121 using xhci_hcd
> > [  257.175003] usb 1-3: New USB device found, idVendor=0b05, idProduct=17e0, bcdDevice= 2.49
> > [  257.175050] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [  257.175073] usb 1-3: Product: ASUS Base Station(T100)
> > [  257.175091] usb 1-3: Manufacturer: ASUSTek COMPUTER INC.
> > [  257.180978] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:0B05:17E0.02DB/input/input749
> > [  257.266585] asus 0003:0B05:17E0.02DB: input,hidraw1: USB HID v1.11 Keyboard [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input0
> > [  257.270711] asus 0003:0B05:17E0.02DC: Fixing up Asus T100 keyb report descriptor
> > [  257.272302] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:0B05:17E0.02DC/input/input750
> > [  257.327059] asus 0003:0B05:17E0.02DC: input,hiddev0,hidraw2: USB HID v1.11 Device [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input1
> > [  257.332642] input: ASUSTek COMPUTER INC. ASUS Base Station(T100) as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.2/0003:0B05:17E0.02DD/input/input751
> > [  257.334115] asus 0003:0B05:17E0.02DD: input,hiddev1,hidraw3: USB HID v1.11 Mouse [ASUSTek COMPUTER INC. ASUS Base Station(T100)] on usb-0000:00:14.0-3/input2
> > [  257.336098] asus 0003:0B05:17E0.02DD: Asus handshake 5d failed to send: -71
> > [  257.336263] asus 0003:0B05:17E0.02DD: Failed to initialize 0x5d: -71.
> > [  257.336605] asus 0003:0B05:17E0.02DD: Asus failed to start multitouch: -71
> > [  257.367022] asus 0003:0B05:17E0.02DD: probe with driver asus failed with error -71
> > [  257.367917] usb 1-3: USB disconnect, device number 121
> >
> > I haven't tried to debug this yet so just FYI.
> >
> 
> Hi Sakari,
> 
> Thanks for testing this! Is that device of yours a touchpad? This commit has been bugfixed before and the issue is related to report sizes being sent as 64 bytes (and also additional unsupported messages in the case of touchpads).
> 
> Can you try linux-next please? That has all bugfixes for already known problems.

I can confirm the issue has been fixed in next.

-- 
Kind regards,

Sakari Ailus
