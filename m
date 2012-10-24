From: simon@mungewell.org
Subject: Re: Multiple clients reading from /dev/input/eventX
Date: Wed, 24 Oct 2012 00:26:17 -0400
Message-ID: <e603df72a1ba52e724eb72802bd93f48.squirrel@mungewell.org>
References: <e6193392fbe49d7236b39e3b17b8fa81.squirrel@mungewell.org>
    <20121019223210.GA10915@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20121024002616_92581"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:44405 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab2JXE0S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 00:26:18 -0400
In-Reply-To: <20121019223210.GA10915@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org

------=_20121024002616_92581
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>> Can anyone here confirm the behaviour under the situation that one
>> client
>> is busy? What is the maximum time it can be 'away' or what is the size
>> of
>> the inline buffer?
>
> Every user of event device has a buffer that can hold up at least 64
> input events and is completely independent from other users. Newer
> kernels generate EV_SYN/SYN_DROPPED event to indicate that user was too
> slow reading data and there was buffer overrun.
>
> Hope this helps.

Yes, very helpful.... I am seeing 'SYN_DROPPED' on my system, so the next
question is how to work around this?

In the event of an overflow is there any method of reading/polling the
last (correct) event value for each of the axis?

In my case on the G27 wheel when your foot transitions from the brake to
accelerator, you get no more 'brake events' to 'refresh' the value.

I see that I could use QUIRK to enlarge the buffer for this device, would
that be an acceptable workaround?
http://www.spinics.net/lists/linux-input/msg15497.html

Attached is a little log showing SDL 'missing' 68 events, which are
correctly reported by 'evtest'. The time stamps in log will give you an
idea about how quickly the events are coming in from this wheel.

Thanks,
Simon.
------=_20121024002616_92581
Content-Type: application/x-gzip; name="SDL_missing_events2.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="SDL_missing_events2.txt.gz"

H4sICJGzgFAAA1NETF9taXNzaW5nX2V2ZW50czIudHh0AK1aS28cNww+r3+FDgG8BjK2SL2D9hCg
7aHIqbm1yMGOp/W2jm1k14u66I8vtUbtSg41ZNBLEGK433D4/Cj51bzfzdudObuc92ebm7v73dm8
n292zvxtfvs835lpNscfby9n8wuGD8dH03T0fX3+xuw2n2YDLtgIYMGflhBTCq/N7uFuNs6s315s
b6/vd/PJa3P4PZr1z/T//fn1PQm+rFbfTJP5dfOZ3r6d5xtz8WDef/eOh88pFim8yyxOtCmiFAcH
OKjBsTyOV+CA43Fiik6KYwOPQ35OQhwohcVJVh4vKMjjkJ+laQU58jgKP0Pm40XeiV6KExOPQ36O
YhxgcbIinyHw+ZMV+Qyej1cmP1spjvM8TlT4x/HxyuTnLMVB/ruKTUn8XcDXRdH4Gfh8Lpp8HvSN
EhU4lu+HRZPPlvmucGqtlfcx4PpYxdH42TL+IRz4n+wBlT28f0ATdy5eFUdTXwCP4/r6vJ3WZo3Z
HAjD9oR/U04JxG9iOgLhoGaiANN5Kw6mJI4oN7krjs9W7EGOSVQcIk7iiDo+MzDLCRh4ZqIQjrOK
iRt4/zhUVE7g/eM8zUrxpOTzx2kyPg1wNJ0ufzVOMOuf/nqmbANHe03ACt+iFnA6g5CZcRVI0+sK
X6kLOL1BfGl4Lye1OGi+CzidQTAIWSggZZE46IkLOK1BQ1dnOa1FHBg0xukMynwyBkW3R47/LeN0
BqWBQYpFBB1fHAs4nUGRYaQVyCsMCmH1OMJ3V5ut2V7d3l9fmqvz/Wwu6jg/DPbHRR+Pv/aNneme
b+khKuoIuG2+AqnSDfnoRk3vg0Fl13MBuUWWH8NR4+wywBkfDLQ4eYCTFc048Q6qBwODhazFGaT/
wsFAixP4jlUPBsT2+AGOxs+DlCayM6KnHQ4fr3owIJ9V/AJUDwbktcr3vaxqHgN7NL2DH3hZ0zn4
qBerIHFsUdDaM9wBOufwMDFbcS6zLgba2OShYtkS7U7ZyzsYD6NKQLbFA3pFgQJboICaBOQLi1bC
lOXslvePsxnEDMfx/nEaP3s+l53PThx2vqHCwr4mbfDgNNkceD97TalH3s8ecxich3QNbIDjFR2M
H+zgNX7OfF14zT5b+HjpGDvPoKAybbFBACzVAB3v5Q6RK5CO9+JqtY7/HrCZ40+b7Xa+PDbfGktZ
nUqJ/KkbLNyXvaDYj9vBD4f7uPdL93GEryPM/C5AG45m9A3qkwhzkn9xHABFBSOENAAa3z301InP
ZBVnRsvXFpHm0Vlsf4AxsEjDmtn7zwqkcTZ7IVuBNAmP/DkqZJWzPUsxQcWcDxt6LcF3L87YwT2d
sU/T0dGr07N6Z3/45/fbh+1u8/EPopb06O2ftNsfVOsNu2lkl1sZe9m2Mr20kW1oZCilk7GVc+zk
Fh9i6mRo5dC+n6ZmKzvfyR0+dvrQ2Qudfd33gs2d3On3/rD97/vn/e87fKDv//Epmua8PsLH3HhD
ax71NrM+PPMlWnfC62KOrkh1ow1iXVdKkOoiZDGuBZTiQg5iP1CGJZDqBqR8EeoSL/VSXeuormS6
tPZLTYiJskemSuRXagCVaBSqJrEHJsAijcKENkozYcIszvLJRapuoa4vVqwbPIhtqH8eJdWNUOQ2
KHA19mr84CnIrW7TmbtO5zs5dJ05dnLqJw10k8l3kwvGk62ffK7tzDTRWzmEl53ZPXdb91yKBb/g
pidV8r5UNWOIQlUaJE6s6zyIdWP4T9Es6Na/1hHqIvVlKW47chZ0m1G2oJsBpTY4WyJIdSvha3WJ
lf0DbAps32QpAAA=
------=_20121024002616_92581--


