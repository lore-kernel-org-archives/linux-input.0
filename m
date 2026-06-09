Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D7438FF2
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013376; cv=none; b=Ohgd59mIjCLgZYWci633KyvEpNRzniRQXji8sExsbCaSunaUo1Pk0fJO/YpCByD8HxdJFDZ/6KNak4JubGUgapthFNIwpvrrJOm07pw7KTmOyLB3kFI9iaxf9ye5mDoUNPpSIfY4bF/czIpo7SplNDinQQH+eXGQ0SdytWnPxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013376; c=relaxed/simple;
	bh=kOVb5UZJ7PirPcKIiVVj7Yi1gTqduCAlASlb/nfrhMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCbjP2/Bz8dzXZkML9o6kSUvPdfxvrlmUDveswY33hEo9iLGElmpbZuoZVH62qAD6/EvYs5syf7UXvp8oLAz3izE/CiMI8NMzAmqvk+nTWi4m7aLqc0NMohlqutRF3RoHP2aSFnx9isP0NIvhotnu+d1WzT+gGbp+aB+NHlIg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNk8nZPY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNk8nZPY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so27619845e9.1
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781013373; x=1781618173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jGyG5daN6w9H2aO200031+C6M/edAKFVis8h8TY864=;
        b=jNk8nZPYX6gCI/oi6DAtN4Ikci3kGzkIwPCapgA5VrBHCnP0nPxpkLyHGTLliXYuDC
         JNuIw3yNbh1BtF1Pa2ei+Eaf+hDRxGVQgoMih50JR34b72AlOKOHdc4zuzHgQxUjcg2H
         Shj2P47jrjAXvPuUMIyZf4lLX2jHbaYSby9RbJALSx2phg2ofvju66ShfJWPBcVYWwMO
         vhVjSVkkmAqu58/ZrRgJP9zFE4TT2TEUgFD9QmSDQor3gh8a++mxwev689yMsFcus/Te
         aP9TBjLGZ9BnPjmodDmTY9SIzzf+EVmETIjZcpDA9ZP+SQ+ch2l47Hl205Gm8ziQXGjV
         nnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013373; x=1781618173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jGyG5daN6w9H2aO200031+C6M/edAKFVis8h8TY864=;
        b=IZNT6uTAIn3IaKlQ+y7046TuWVaHAvrcIC79FKiM+Fw+J5jvpi70GWTYf0+uglKcQb
         PZyLpi0gOdX0NPL29wNrFAF5gFEReeJOhc1GTHeppm4DB2Y3jj4dsQcDNoP9yr0KudrW
         arAHl75813orqW3FyHnBM2Fu1T0l/Y91tPcPzLI1DUPlKGOsUKS0MyarQDlsCBtNoYb7
         r8rNXzDLKf9ye8s/xOd8+6GPP4Ra4osn3+PiOOUu12Vg6TLmhgqB9Rs9xFMfZp9DVbQt
         S6THp9lu31XYmsUOHZpcYsZNPp4tdPUkyHqCeBpdphQXkX6hEpwt5YoumBrQxW09ybgl
         pJlw==
X-Forwarded-Encrypted: i=1; AFNElJ/pqEA1hfN9rgcK9n28ozMoPgz7UprY750rK8ef66kCjQbcl/MPaw6aym0ZR13d8kapgeHiIX7vzVB1EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkrJI7Pwm5BCsWUW3jPQ3FPOeEVCu2e9b81iB9xM7iezSuyv3
	YSjUzoQLZb8NMp+W6M9+gmHcs5g2I3g+BGAQEA6MIl7wpxmhqCFWieMb
X-Gm-Gg: Acq92OG7f0G1uI3ymI1DQSAPYVS8tCIUxcWEQXjKHFT+mj6aNjJpVZ/2oxdA+kKo5Xe
	neVaP24dT/TylGECkZPb7kWaAFLm3RVvBcvL1ODc4PPkxEOkVb1dyLtmd4GbhVDifSqwW/VO3oU
	5L0bjE/XkENh4TzSJCaFccE6PQnO+ycxjlbhS9yQ0hSZdtXsr8T9hZh2Y3d25uNNShAbAup23d2
	auJCB5DQMq/yNSWsE2Asx7b+naHFF0jpyHwyN4eH91SXnOZywAv6+MoDMDXoIsIhxQSvX1Z0xiU
	XoclqIF/TMWophwqXMWPB3DYDocLd6ZmYy0z677WWeRpe4zqPx1fLqsKQ7eqO+Z1iD2ZFNBkc7i
	T1fYMjkoMgMz5G6HnTPqBle0uRp/nAWcSopkyaeR11YVwaubtS/Q/oGhh+3ZsJkttGNEpcMzwj2
	rlBCrbuZ6lYxhpFHayrLu59joVGWZyeYnHc/kl0cUns8ihwVpsgg==
X-Received: by 2002:a05:600c:6389:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490c26233abmr347947135e9.20.1781013372639;
        Tue, 09 Jun 2026 06:56:12 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fcf5bsm575882985e9.9.2026.06.09.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:12 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: conor@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	jerrysteve1101@gmail.com,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: input: microchip,cap11xx: Cleanup and refine LED constraints
Date: Tue,  9 Jun 2026 21:56:03 +0800
Message-ID: <20260609135603.848573-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-mooned-ambiguous-02493b8d383e@spud>
References: <20260608-mooned-ambiguous-02493b8d383e@spud>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Sat, Jun 06, 2026 at 11:03:56PM +0800, Jun Yan wrote:
> > Add detailed datasheet links for all supported CAP11xx devices.
> >=20
> > Unify LED node pattern to support all chip variants in preparation
> > for CAP1114 support.
> >=20
> > Remove redundant LED properties inherited from common.yaml
> >=20
> > Apply per-chip LED channel limits:
> > - CAP1126: max 2 channels (0-1)
> > - CAP1188: max 8 channels (0-7)
> > - CAP1106, CAP12xx: no LED support
> >=20
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > ---
> >  .../bindings/input/microchip,cap11xx.yaml     | 51 ++++++++++++++-----
> >  1 file changed, 37 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
> ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > index 7ade03f1b32b..99d00f572a2d 100644
> > --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > @@ -10,6 +10,15 @@ description: |
> >    The Microchip CAP1xxx Family of RightTouchTM multiple-channel capaciti=
> ve
> >    touch controllers and LED drivers. The device communication via I2C on=
> ly.
> > =20
> > +  For more product information please see the links below:
> > +    CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.=
> pdf
> > +    CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.=
> pdf
> > +    CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.=
> pdf
> > +    CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.=
> pdf
> > +    CAP1206: https://ww1.microchip.com/downloads/en/DeviceDoc/00001567B.=
> pdf
> > +    CAP1293: https://ww1.microchip.com/downloads/en/DeviceDoc/00001566B.=
> pdf
> > +    CAP1298: https://ww1.microchip.com/downloads/en/DeviceDoc/00001571B.=
> pdf
> > +
> >  maintainers:
> >    - Rob Herring <robh@kernel.org>
> > =20
> > @@ -124,25 +133,21 @@ properties:
> >        The number of entries must correspond to the number of channels.
> > =20
> >  patternProperties:
> > -  "^led@[0-7]$":
> > +  "^led@[0-9a-f]$":
> >      type: object
> >      description: CAP11xx LEDs
> >      $ref: /schemas/leds/common.yaml#
> > =20
> >      properties:
> >        reg:
> > -        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > -
> > -      label: true
> > -
> > -      linux,default-trigger: true
> > -
> > -      default-state: true
> > +        description: LED channel number
> > +        minimum: 0
> > +        maximum: 7
> > =20
> >      required:
> >        - reg
> > =20
> > -    additionalProperties: false
> > +    unevaluatedProperties: false
> 
> > Remove redundant LED properties inherited from common.yaml
> 
> But the pattern here suggests they aren't redundant, this is how you say
> "these properties are the only common ones allowed". You need to explain
> why other ones are valid to change this.
> 

I checked other LED dt-bindings and related driver code. 
This change is not suitable and will be dropped in V2.

> pw-bot: changes-requested
> (a commit message change is required at least)
> 
> > =20
> >  allOf:
> >    - $ref: input.yaml
> > @@ -158,7 +163,20 @@ allOf:
> >                - microchip,cap1298
> >      then:
> >        patternProperties:
> > -        "^led@[0-7]$": false
> > +        "^led@": false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - microchip,cap1126
> > +    then:
> > +      patternProperties:
> > +        "^led@":
> > +          properties:
> > +            reg:
> > +              maximum: 1
> 
> I think these changes to permitted properties should be a standalone
> patch.

Agreed. I will split these changes into a standalone patch for V2.

> Thanks,
> Conor.
> 
> > =20
> >    - if:
> >        properties:
> > @@ -183,6 +201,9 @@ additionalProperties: false
> > =20
> >  examples:
> >    - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/leds/common.h>
> > +
> >      i2c {
> >        #address-cells =3D <1>;
> >        #size-cells =3D <0>;
> > @@ -208,19 +229,21 @@ examples:
> >          #size-cells =3D <0>;
> > =20
> >          led@0 {
> > -                label =3D "cap11xx:green:usr0";
> >                  reg =3D <0>;
> > +                function =3D LED_FUNCTION_INDICATOR;
> > +                color =3D <LED_COLOR_ID_GREEN>;
> >          };
> > =20
> >          led@1 {
> > -                label =3D "cap11xx:green:usr1";
> >                  reg =3D <1>;
> > +                function =3D LED_FUNCTION_INDICATOR;
> > +                color =3D <LED_COLOR_ID_GREEN>;
> >          };
> > =20
> >          led@2 {
> > -                label =3D "cap11xx:green:alive";
> >                  reg =3D <2>;
> > -                linux,default-trigger =3D "heartbeat";
> > +                function =3D LED_FUNCTION_INDICATOR;
> > +                color =3D <LED_COLOR_ID_GREEN>;
> >          };
> >        };
> >      };
> > --=20
> > 2.54.0
> >=20
