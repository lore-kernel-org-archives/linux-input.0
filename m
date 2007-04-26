From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Fri, 27 Apr 2007 01:24:25 +0200
Message-ID: <463134A9.7020001@gmail.com>
References: <210731960111436322@karneval.cz> <462688AB.4060707@gmail.com>	 <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>	 <200704190058.11625.dtor@insightbb.com> <46278CDD.2000007@gmail.com>	 <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>	 <4af2d03a0704220557u5d6368a2t13878b73bf9dbe64@mail.gmail.com> <d120d5000704260902h7950b30bi7a5a604c16f23421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000704260902h7950b30bi7a5a604c16f23421@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-kernel@vger.kernel.org, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov napsal(a):
> On 4/22/07, Jiri Slaby <jirislaby@gmail.com> wrote:
>> I think we won't be able to make the transition in independent way
>> due to unspecified meaning of the torques.
>>
> 
> With phantom it still seems doable - if I understand correctly ther is
> one point of containct and one resulting vector of forces applied to
> user's hand. With the glove there are multiple points of contact and
> multiple feedback effects applied to different part of hand
> simultaneously and that is for sure requires special application.

Hi.

Good news are, that I've got openhaptics (OS independent layer for sensable
devices) under academic license (I don't know, what the "open" word in that name
means -- no sourcecodes; licensed), the bad ones are, that they use ioctl
approach for both reporting and FF.

Furthermore I tried phantom with input layer in X and realized, that it's needed
to compute real axies from that numbers and that's what I'm doing in userspace
with doubke precision.

Ok, so the question is if the old ioctl approach (something which I posted as a
first patch before we ever starrted to talk about FF and input layer without
mmaping anything to US) is acceptable alone (this is what is needed for
OHaptics) or at least some particular computing to convert the numbers and
reporting to input layer should be implemented (which will have no users anyway,
who will ever want to have 60000$ pointer ;))?

thanks a lot,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
