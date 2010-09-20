From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 1/3] hid: 3m: Adjust to sequential MT HID protocol
Date: Mon, 20 Sep 2010 20:21:51 +0200
Message-ID: <1213242F-BA51-4D3C-93F9-5CF29DEC513B@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283005748-3293-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :

> The multitouch extensions to the HID protocol allows for contact
> data to be sent over several reports, which is also the case for
> the 3M M2256PW touchscreen. This patch modifies the logic to only
> synchronize the input layer when all contacts have been received.
> Consequentially, the full 60-finger capacity of the device is enabled=
=2E
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hid/hid-3m-pct.c |   22 ++++++++++++++++++----
>  1 files changed, 18 insertions(+), 4 deletions(-)

You can add

Acked-by: Stephane Chatty <chatty@enac.fr>

St.
