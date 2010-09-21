From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/3] hid: 3m: Correct touchscreen emulation
Date: Tue, 21 Sep 2010 19:00:39 +0200
Message-ID: <B5146B49-1D7A-4AFD-B925-3F35E83A2A96@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se> <1283005748-3293-3-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283005748-3293-3-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :

> The current code sometimes misses to report the last BTN_TOUCH event
> when multiple fingers are lifted simultaneously.  With the
> introduction of MT slots, the tracking id is available to determine
> the oldest active contact. Use this information to simplify and
> correct the touchscreen emulation logic.
>

Acked-by: St=E9phane Chatty <chatty@enac.fr>

Cheers,

St.
