From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 2/3] hid: 3m: Convert to MT slots
Date: Mon, 20 Sep 2010 22:01:57 +0200
Message-ID: <6A8BB954-78BB-4507-86F3-19DA5174FA5E@enac.fr>
References: <1283005748-3293-1-git-send-email-rydberg@euromail.se>  <1283005748-3293-2-git-send-email-rydberg@euromail.se>  <CE1C24FC-7C9A-4940-8141-391A368C59E5@enac.fr> <4C97BB33.5020806@euromail.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C97BB33.5020806@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Le 20 sept. 10 =E0 21:51, Henrik Rydberg a =E9crit :

> On 09/20/2010 09:46 PM, St=E9phane Chatty wrote:
>
>>
>> Le 28 ao=FBt 10 =E0 16:29, Henrik Rydberg a =E9crit :
>>
>>>  #define MAX_SLOTS        60
>>> -#define MAX_TRKID        59
>>> +#define MAX_TRKID        USHRT_MAX
>>>
>>
>> Oops, I forgot this one: in the rest of the code, it seems to me =20
>> that you use
>> your knowledge that TRACKINGID cannot be more than 59 (you use it =20
>> to map the
>> tracking ID onto the slot ID). Therefore, why change TRKID to a =20
>> larger value?
>
>
> There are only 60 slots available, but an infinite number of =20
> tracking ids.
> Nowhere is the tracking id assumed to be bounded by anything but =20
> MAX_TRKID.
>

What about this:
+			value =3D clamp_val(value, 0, MAX_SLOTS - 1);
  			if (md->valid) {
  				md->curid =3D value;
  				md->f[value].touch =3D md->touch;

If you had tracking IDs 59, 60 and 61 in the same frame, this would =20
not work properly would it?

St.
