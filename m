From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics_rmi4 - register F03 port as pass-through serio
Date: Thu, 8 Jun 2017 13:58:44 +0200
Message-ID: <CAEk1YH6b81R94cMJo6jc7emT2PDCfPcmqkfzQ4S9wcDCrj6Jvw@mail.gmail.com>
References: <20170607065128.GA31686@dtor-ws> <20170607070255.GA16591@mail.corp.redhat.com>
 <20170607165953.GB13116@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35737 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdFHL6q (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 07:58:46 -0400
In-Reply-To: <20170607165953.GB13116@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-kernel@vger.kernel.org

>> Thanks for the extensive commit message :)
>>
>> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Thanks Benjamin.
>
> Damjan, could you please try this patch too before I send it Linus-wards.

Hi Dmitry,

I'm not sure what to expect from the patch?
It didn't change anything for me with the default "modprobe psmouse".

when using `modprobe psmouse synaptics_intertouch=3D1`, I don't get the
trackpoint (nor its buttons) at all.

$ xinput
=E2=8E=A1 Virtual core pointer                          id=3D2    [master p=
ointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4    [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Synaptics TM3289-002                      id=3D11   [=
slave  pointer  (2)]






--=20
damjan
