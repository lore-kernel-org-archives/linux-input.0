From: "Vincent Vanackere" <vincent.vanackere@gmail.com>
Subject: Re: [PATCH] Make ati_remote button repeat sensitivity soft-configurable
Date: Wed, 4 Apr 2007 10:45:34 +0200
Message-ID: <65258a580704040145m6eb7108frfa8197d3b88e207a@mail.gmail.com>
References: <f9be06770704031734k11ec894fpdf1afe385108aece@mail.gmail.com>
	 <461357D8.8060608@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <461357D8.8060608@tremplin-utc.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Karl Pickett <karl.pickett@gmail.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 4/4/07, =C9ric Piel <Eric.Piel@tremplin-utc.net> wrote:

> This default value is set to 300 ms. On my Xserver, the default value is
> 660 ms and by default in my distrib it's set to 500 ms. So, indeed, the
> default value of the ati_remote is quite small. Maybe you could increase
> FILTER_MAX to 10 (=3D 600 ms) in order to have something saner?

Well, this value was chosen because it matches what the hardware does
: as explained in the comments, the hardware generates exactly 5
events for the first keypress (spaced by ~50ms if I recall correctly).

At least on my hardware (=3D> Vendor=3D0bc7 ProdID=3D0004 Rev=3D 1.00), the
current default value match exactly what I'm expecting (never had the
problem : "if you do anything but barely tap the button you can get
multiple events reported").
Just a thought : perhaps some models are more sensitive than others
(and so the default should be made dependent on the exact remote
model)... what is your hardware id ?

Best regards,

Vincent
