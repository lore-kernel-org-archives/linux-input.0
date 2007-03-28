From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom driver]
Date: Tue, 27 Mar 2007 23:08:33 -0400
Message-ID: <200703272308.34441.dtor@insightbb.com>
References: <2460126662758025813@fi.muni.cz> <460983D6.7070409@gmail.com> <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, "\"STenyaK (Bruno =?iso-8859-1?q?Gonz=E1lez?=)\"" <stenyak@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tuesday 27 March 2007 17:34, johann deneux wrote:
> What about adding a member to ff_effect which would be the number of the motor?
> We can't change the layout of ff_effect too much though, so we have to
> find unused bits and put them to work.
> 
> For instance, we could replace
> 
> __u16 type;
> 
> by
> 
> __u8 motor;
> __u8 type;
> 

Splitting type field seems to be a good idea.

-- 
Dmitry
