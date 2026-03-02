Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE700430BAA;
	Mon,  2 Mar 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415220; cv=none; b=iwfw/FWnTxfRCEgyK6RYL2h4oxbGApqxLf2nGdDWrPRgtseTCI2FrsKOQzs8yi6ox6w+aJUEOwAOjtk1A/GIcOh5mo3EcSA6US780JDOodKozovUk3v/zKmpE/wRNvBgxSAAm464cnO0ZTvj3cgAVHVxhwpAzfdy8f80H/uU6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415220; c=relaxed/simple;
	bh=jM1G2cXkoiObbiy/I5gO/C7xyNi2D1Ki/RC17uDdbl8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MrhCBromWEhzbMQEqWBwfA0wOynWQ2FWSXdwobq41SuYW1H4r5TlCH3DbhrZKawzMCpC1/FPy5LYjzbL6n6JVOG+u6YIEp9NQf8h0MCoEIFS+3Ks7yTt6/vprZv+5MTia6QdBBetXEDYBS0fs4h475VowJELrRN2U+Jdeqi9A+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=J9KwoovR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yTImf8j4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="J9KwoovR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yTImf8j4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F2892EC00AE;
	Sun,  1 Mar 2026 20:33:37 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 01 Mar 2026 20:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772415217;
	 x=1772501617; bh=eiDQlDMqCFQ/Oq7RN5j24buznoJKC6c7a8guwOj6ycc=; b=
	J9KwoovRJk3hJ1oyu1VSL1IVuNBRBump2U1s345/dm9wijrQWE2Me9cyVGR/q9+v
	XDVs/hjq5yUiIs5BSJ4p/CRkT/q8yE8jgfbvjm3EnP4h/flrtC8qQBY7IJQ2u+H+
	avA6SLD6o13Fig7YdHzDfg9+bRKY4ZYzUllZB5C3JZ45pXPeTHLFEm2YPWhu/Den
	jeXDSnE5jvlRKyR6gLC3ozOvCcOUKxrzlgzJTxo+XA7OG9VEr0pEalkwkGIpJ4AI
	q7FLR4Edl30hhPznR8SHzxScGCi0zlNudGrENyR4QbSHMstiuZ0bsNDSkirX5A41
	otXbuQfnv5fA3mrmilBH8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772415217; x=
	1772501617; bh=eiDQlDMqCFQ/Oq7RN5j24buznoJKC6c7a8guwOj6ycc=; b=y
	TImf8j4Mr+MBbmKz548jnhIibNwRMSzDZ1y7p+ZAIucCj5owBmE6EBaHCB8RaL63
	ocriO4GTb7zbAS/hp4XsmrpmO2/M6hOCHRL8E3w7CypNsqFU7sB2/oIFa6hO9b2j
	A6cL/DoJ3/wuVZBoP89gumG+M4tdvsaneyAONrVo/VkfBnVxTISoiOfopTmFgGli
	2xo+NQWUbAv/ulSj9Ja6/22Iykf8sbysSaqOKgZEZwS3ZBYgIGYNhOfFbvQG7Ly/
	w5myZ0PLcXOHIHeFeopV0zY0KaXQxJu8OfhPJdO3xSmit+4vbc61n9lgruccodkF
	n7Ejo060XlUKvrlx0p4Ow==
X-ME-Sender: <xms:8eikaSYdSFYgFU61WUgKF25GtGCdYgMC_9kQGSCKVCYlugR_mLDl4Q>
    <xme:8eikaQNhezUNRwAdd0xM-IOxUqDa7mkycef-VDZWSkw7CdEzpVOZgwDJmHezX4yjF
    IaMVEbyW6bcBufiqb1YwMI6-ynvl69JHnw5WVCcY47o7AemLUjcRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvg
    hkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitghhvghn
    sehishgtrghsrdgrtgdrtghnpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8eikac_fLBnsP6zQ3CLv6umQoeKvIO6d86URbb_3_w3aGLcwXZGu7g>
    <xmx:8eikaW9J0dz2d9udSDdiH-RJFLWrl7OFji0Jj8NCktESFlYwdwiSWA>
    <xmx:8eikaUTarexNetcid2ypw59VopceHiPkWiPMBSUiwekMt03Hp0QUKQ>
    <xmx:8eikaSd1frW91kYPTWIJQEhPg_9KeneMCMlzyLc4YYReoWbo1k6kjQ>
    <xmx:8eikaaCPSkgUwjmSNcB238qgBNzR36L8V63Vwyc53cDxnknEwJcZbHvv>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3B212CE0072; Sun,  1 Mar 2026 20:33:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwZ6U0sl_71s
Date: Sun, 01 Mar 2026 20:33:17 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Chen Ni" <nichen@iscas.ac.cn>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <0e072068-6e13-4522-9c02-62d9855f0f2e@app.fastmail.com>
In-Reply-To: <20260228033936.285945-1-nichen@iscas.ac.cn>
References: <20260228033936.285945-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] HID: hid-lenovo-go: Remove unneeded semicolon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 27, 2026, at 10:39 PM, Chen Ni wrote:
> Remove unnecessary semicolons after switch statements and function
> bodies. Most issues were reported by Coccinelle/coccicheck using the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci. Additional
> instances found during manual code review were also fixed.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/hid/hid-lenovo-go.c | 52 ++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 6972d13802e2..77e3823447e5 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -455,7 +455,7 @@ static int hid_go_feature_status_event(struct 
> command_report *cmd_rep)
>  			return 0;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  	case FEATURE_IMU_BYPASS:
>  		switch (cmd_rep->device_type) {
>  		case LEFT_CONTROLLER:
> @@ -466,7 +466,7 @@ static int hid_go_feature_status_event(struct 
> command_report *cmd_rep)
>  			return 0;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		break;
>  	case FEATURE_LIGHT_ENABLE:
>  		drvdata.rgb_en = cmd_rep->data[0];
> @@ -481,7 +481,7 @@ static int hid_go_feature_status_event(struct 
> command_report *cmd_rep)
>  			return 0;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		break;
>  	case FEATURE_TOUCHPAD_ENABLE:
>  		drvdata.tp_en = cmd_rep->data[0];
> @@ -515,7 +515,7 @@ static int hid_go_motor_event(struct command_report 
> *cmd_rep)
>  			return 0;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		break;
>  	case RUMBLE_MODE:
>  		switch (cmd_rep->device_type) {
> @@ -527,7 +527,7 @@ static int hid_go_motor_event(struct command_report 
> *cmd_rep)
>  			return 0;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  	case TP_VIBRATION_ENABLE:
>  		drvdata.tp_vibration_en = cmd_rep->data[0];
>  		return 0;
> @@ -625,7 +625,7 @@ static int hid_go_os_mode_cfg_event(struct 
> command_report *cmd_rep)
>  		return 0;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
>  }
> 
>  static int hid_go_set_event_return(struct command_report *cmd_rep)
> @@ -699,14 +699,14 @@ static int hid_go_raw_event(struct hid_device 
> *hdev, struct hid_report *report,
>  		default:
>  			ret = -EINVAL;
>  			break;
> -		};
> +		}
>  		break;
>  	case OS_MODE_DATA:
>  		ret = hid_go_os_mode_cfg_event(cmd_rep);
>  		break;
>  	default:
>  		goto passthrough;
> -	};
> +	}
>  	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
>  		GO_PACKET_SIZE, data);
> 
> @@ -925,7 +925,7 @@ static ssize_t feature_status_store(struct device *dev,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> 
>  	if (ret < 0)
>  		return ret;
> @@ -1013,7 +1013,7 @@ static ssize_t feature_status_show(struct device *dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		count = sysfs_emit(buf, "%u\n", i);
>  		break;
>  	case FEATURE_FPS_SWITCH_STATUS:
> @@ -1032,7 +1032,7 @@ static ssize_t feature_status_show(struct device *dev,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> 
>  	return count;
>  }
> @@ -1070,7 +1070,7 @@ static ssize_t feature_status_options(struct device *dev,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> 
>  	if (count)
>  		buf[count - 1] = '\n';
> @@ -1111,7 +1111,7 @@ static ssize_t motor_config_store(struct device *dev,
>  		ret = sysfs_match_string(intensity_text, buf);
>  		val = ret;
>  		break;
> -	};
> +	}
> 
>  	if (ret < 0)
>  		return ret;
> @@ -1161,7 +1161,7 @@ static ssize_t motor_config_show(struct device *dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		if (i >= ARRAY_SIZE(enabled_status_text))
>  			return -EINVAL;
> 
> @@ -1177,7 +1177,7 @@ static ssize_t motor_config_show(struct device *dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -		};
> +		}
>  		if (i >= ARRAY_SIZE(rumble_mode_text))
>  			return -EINVAL;
> 
> @@ -1197,7 +1197,7 @@ static ssize_t motor_config_show(struct device *dev,
> 
>  		count = sysfs_emit(buf, "%s\n", intensity_text[i]);
>  		break;
> -	};
> +	}
> 
>  	return count;
>  }
> @@ -1232,7 +1232,7 @@ static ssize_t motor_config_options(struct device *dev,
>  					       enabled_status_text[i]);
>  		}
>  		break;
> -	};
> +	}
> 
>  	if (count)
>  		buf[count - 1] = '\n';
> @@ -1333,7 +1333,7 @@ static ssize_t device_status_show(struct device *dev,
>  		break;
>  	default:
>  		return -EINVAL;
> -	};
> +	}
> 
>  	if (i >= ARRAY_SIZE(cal_status_text))
>  		return -EINVAL;
> @@ -1459,7 +1459,7 @@ static int rgb_attr_show(void)
>  	index = drvdata.rgb_profile + 3;
> 
>  	return rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, index, 0, 0);
> -};
> +}
> 
>  static ssize_t rgb_effect_store(struct device *dev,
>  				struct device_attribute *attr, const char *buf,
> @@ -1489,7 +1489,7 @@ static ssize_t rgb_effect_store(struct device *dev,
> 
>  	drvdata.rgb_effect = effect;
>  	return count;
> -};
> +}
> 
>  static ssize_t rgb_effect_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
> @@ -1552,7 +1552,7 @@ static ssize_t rgb_speed_store(struct device *dev,
>  	drvdata.rgb_speed = val;
> 
>  	return count;
> -};
> +}
> 
>  static ssize_t rgb_speed_show(struct device *dev, struct 
> device_attribute *attr,
>  			      char *buf)
> @@ -1594,7 +1594,7 @@ static ssize_t rgb_mode_store(struct device *dev, 
> struct device_attribute *attr,
>  	drvdata.rgb_mode = val;
> 
>  	return count;
> -};
> +}
> 
>  static ssize_t rgb_mode_show(struct device *dev, struct 
> device_attribute *attr,
>  			     char *buf)
> @@ -1609,7 +1609,7 @@ static ssize_t rgb_mode_show(struct device *dev, 
> struct device_attribute *attr,
>  		return -EINVAL;
> 
>  	return sysfs_emit(buf, "%s\n", rgb_mode_text[drvdata.rgb_mode]);
> -};
> +}
> 
>  static ssize_t rgb_mode_index_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -1649,7 +1649,7 @@ static ssize_t rgb_profile_store(struct device *dev,
>  	drvdata.rgb_profile = val;
> 
>  	return count;
> -};
> +}
> 
>  static ssize_t rgb_profile_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
> @@ -1665,7 +1665,7 @@ static ssize_t rgb_profile_show(struct device *dev,
>  		return -EINVAL;
> 
>  	return sysfs_emit(buf, "%hhu\n", drvdata.rgb_profile);
> -};
> +}
> 
>  static ssize_t rgb_profile_range_show(struct device *dev,
>  				      struct device_attribute *attr, char *buf)
> @@ -1704,7 +1704,7 @@ static void hid_go_brightness_set(struct 
> led_classdev *led_cdev,
>  		break;
>  	default:
>  		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n", ret);
> -	};
> +	}
>  }
> 
>  #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
> -- 
> 2.25.1

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
