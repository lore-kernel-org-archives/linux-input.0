From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom
 driver]
Date: Wed, 14 Mar 2007 19:15:33 +0100
Message-ID: <45F83BC5.7020606@gmail.com>
References: <2460126662758025813@fi.muni.cz>	 <d120d5000703070647t223f8858i8c495dcc3e1378a2@mail.gmail.com>	 <45EEEAA3.50009@gmail.com>	 <d120d5000703070856of068f19k62c5a7ce1f829336@mail.gmail.com>	 <4af2d03a0703130919nb4893b1ja9ec795dcf4bf53c@mail.gmail.com>	 <38b3b7c0703131450v2646e63fj2be4b9dda7f928c0@mail.gmail.com>	 <45F722CE.9000602@gmail.com> <d120d5000703140802jb48bc74tbbe7ee2b120b1798@mail.gmail.com> <45F82626.8000108@gmail.com> <45F83930.4060401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45F83930.4060401@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, johann deneux <johann.deneux@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Anssi Hannula napsal(a):
> Jiri Slaby wrote:
>> Dmitry Torokhov napsal(a):
>>> On 3/13/07, Jiri Slaby <jirislaby@gmail.com> wrote:
>>>> Why did you remove all Cced people? Anyway I filtered some of them out
>>>>
>>>> johann deneux napsal(a):
>>>>> You are right, the direction in ff_effect is meant to be an angle.
>>>>> A dirty solution would be to use the 16 bits as two 8-bits angles. Or
>>>> That would be a problem as I need 3x 16bits.
> 
> Interesting. What kind of device is that? i.e. what is the third
> direction value?

6DOF sensable phantom:
http://www.sensable.com/haptic-phantom-premium-6dof.htm

X,Y,Z,RX,RY,RZ+BUT as inputs
X,Y,Z motors as FF

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
