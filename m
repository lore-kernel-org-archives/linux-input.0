From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH] Make ati_remote button repeat sensitivity soft-configurable
Date: Wed, 04 Apr 2007 09:46:32 +0200
Message-ID: <461357D8.8060608@tremplin-utc.net>
References: <f9be06770704031734k11ec894fpdf1afe385108aece@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <f9be06770704031734k11ec894fpdf1afe385108aece@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Karl Pickett <karl.pickett@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

04/04/2007 02:34 AM, Karl Pickett wrote/a =C3=A9crit:
> The ati_remote driver is a little too sensitive for my wife... if you
> do anything but barely tap the button you can get multiple events
> reported.  We prefer a more conservative no-repeat setting.  This is a
> pretty trivial patch which just makes one hard coded value soft
> configurable and does not change the default.
This default value is set to 300 ms. On my Xserver, the default value is=20
660 ms and by default in my distrib it's set to 500 ms. So, indeed, the=20
default value of the ati_remote is quite small. Maybe you could increase=20
FILTER_MAX to 10 (=3D 600 ms) in order to have something saner?

That was my two cents :-)
See you,
Eric
